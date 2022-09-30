import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/blocs/contact_management/grup_pelanggan/grup_pelanggan_bloc.dart';
import '../../../../../models/grup_pelanggan.dart';
import '../../../../../models/kontak_pelanggan.dart';
import 'edit_kontak_pelanggan_state.dart';

class EditKontakPelangganBloc extends Cubit<EditKontakPelangganState> {
  EditKontakPelangganBloc() : super(EditKontakPelangganInitial());

  final List<String> dummyListGroup =
      GrupPelangganBloc().dummyListGrup.map((e) => e.name.toUpperCase()).toList();

  List<String> selectedListGroup = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController handphoneController = TextEditingController();

  String? validationDropdownResult;
  int? selectedId;

  void init(KontakPelanggan data) {
    nameController.text = data.name;
    handphoneController.text = data.number;
    selectedListGroup = data.types.map((e) => e.name.toUpperCase()).toList();
    selectedId = data.id;
    emit(EditKontakPelangganLoaded());
  }

  updateState() {
    emit(EditKontakPelangganChangeState());
  }

  List<GrupPelanggan> getListGroup() {
    List<GrupPelanggan> dataList = [];
    for (var element in GrupPelangganBloc().dummyListGrup) {
      for (var selected in selectedListGroup) {
        if (element.name.toUpperCase() == selected) {
          dataList.add(element);
        }
      }
    }
    return dataList;
  }

  KontakPelanggan createContactObj() {
    return KontakPelanggan(
        id: selectedId ?? -1,
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
    emit(EditKontakPelangganChangeState());
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
