import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/edit_konta_pelanggan/edit_kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

class EditKontakPelangganBloc extends Cubit<EditKontakPelangganState> {
  EditKontakPelangganBloc() : super(EditKontakPelangganInitial());

  final List<String> dummyListGroup =
      GrupPelanggan.values.map((e) => e.value).toList();

  List<String> selectedListGroup = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController handphoneController = TextEditingController();

  String? validationDropdownResult;
  int? selectedId;

  void init(KontakPelanggan data) {
    nameController.text = data.name;
    handphoneController.text = data.number;
    selectedListGroup = data.types.map((e) => e.value).toList();
    selectedId = data.id;
    emit(EditKontakPelangganLoaded());
  }

  updateState() {
    emit(EditKontakPelangganChangeState());
  }

  List<GrupPelanggan> getListGroup() {
    List<GrupPelanggan> dataList = [];
    for (var element in GrupPelanggan.values) {
      for (var selected in selectedListGroup) {
        if (element.value == selected) {
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
