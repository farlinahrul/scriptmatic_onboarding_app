import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/create_kontak_pelanggan/create_kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

import '../grup_pelanggan/grup_pelanggan_bloc.dart';

class CreateKontakPelangganBloc extends Cubit<CreateKontakPelangganState> {
  CreateKontakPelangganBloc() : super(CreateKontakPelangganInitial());

  // final List<String> dummyListGroup = [];
  final List<String> dummyListGroup =
      GrupPelangganBloc().dummyListGrup.map((e) => e.name).toList();

  List<String> selectedListGroup = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController handphoneController = TextEditingController();

  String? validationDropdownResult;

  /*  For Backend Component  */
  void init() {
    emit(CreateKontakPelangganLoaded());
    // emit(KontakPelangganLoaded([]));
  }

  setSelectedList() {
    emit(CreateKontakPelangganChangeState());
  }

  List<GrupPelanggan> getListGroup() {
    List<GrupPelanggan> dataList = [];
    for (var element in GrupPelangganBloc().dummyListGrup) {
      for (var selected in selectedListGroup) {
        if (element.name == selected) {
          dataList.add(element);
        }
      }
    }
    return dataList;
  }

  KontakPelanggan createContactObj(int id) {
    return KontakPelanggan(
        id: id,
        name: nameController.text,
        number: handphoneController.text,
        types: getListGroup(),
        created: 100);
  }

  void validateDropdown() {
    if (selectedListGroup.isEmpty) {
      validationDropdownResult = "Wajib Diisi!";
    } else {
      validationDropdownResult = null;
    }
    emit(CreateKontakPelangganChangeState());
  }

  bool isCompleted() {
    if (nameController.text != "" &&
        handphoneController.text != "" &&
        selectedListGroup.isNotEmpty) {
      return true;
    }
    return false;
  }
}
