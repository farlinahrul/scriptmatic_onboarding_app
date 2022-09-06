import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/create_kontak_pelanggan/create_kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

class CreateKontakPelangganBloc extends Cubit<CreateKontakPelangganState> {
  CreateKontakPelangganBloc() : super(CreateKontakPelangganInitial());

  // final List<String> dummyListGroup = [];
  final List<String> dummyListGroup =
      GrupPelanggan.values.map((e) => e.value).toList();

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
    for (var element in GrupPelanggan.values) {
      for (var selected in selectedListGroup) {
        if (element.value == selected) {
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
