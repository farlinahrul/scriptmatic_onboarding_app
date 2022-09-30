import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/data/blocs/contact_management/kontak_pelanggan/sinkronisasi_kontak/sinkronisasi_kontak_state.dart';

import '../../../../../models/kontak_pelanggan.dart';

class SinkronisasiKontakBloc extends Cubit<SinkronisasiKontakState> {
  SinkronisasiKontakBloc() : super(SinkronisasiKontakInitial());

  List<KontakPelanggan> listData = [];
  List<KontakPelanggan> listDataTemp = [];
  

  Future<void> fetchData(final Future<dynamic> Function() onSuccess) async {
    emit(SinkronisasiKontakLoading());
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      List<Contact> contacts = await ContactsService.getContacts();
      listData = [];
      listDataTemp = [];
      for (var element in contacts) {
        element.phones?.forEach((phone) async {
          listDataTemp.add(
            KontakPelanggan(
              name: element.displayName ?? "",
              number: phone.value ?? "",
              types: [],
              created: 101,
            ),
          );
        });
      }
      await onSuccess();
      emit(SinkronisasiKontakLoaded());
    }
    emit(SinkronisasiKontakError());
    // _handleInvalidPermissions(permissionStatus);
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void changeStatusItem(KontakPelanggan data, isNeedToAdd) {
    if (isNeedToAdd) {
      listData.add(data);
    } else {
      listData.remove(data);
    }
    debugPrint(listData.length.toString());
    emit(SinkronisasiKontakChangeState());
  }

  bool isSelected(KontakPelanggan data) {
    return listData.contains(data);
  }

  addAllData(Function(KontakPelanggan) func) {
    for (var element in listData) {
      func(element);
    }
    listData = [];
    listDataTemp = [];
  }
}
