import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/grup_pelanggan/edit_grup_pelanggan/edit_grup_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/grup_pelanggan/grup_pelanggan_bloc.dart'
    as grup;

import '../../../../../../utils/hex_color.dart';
import '../../kontak_pelanggan_bloc.dart';
import '../grup_pelanggan_bloc.dart';

class EditGrupPelangganBloc extends Cubit<EditGrupPelangganState> {
  EditGrupPelangganBloc() : super(EditGrupPelangganInitial());

  List<KontakPelanggan> selectedListKontak = [];
  List<KontakPelanggan> selectedListKontakTemp = [];

  // Component GroupDetail
  TextEditingController groupNameController = TextEditingController();
  TextEditingController hexColorController = TextEditingController();
  Color? selectedColor;
  Color? selectedTempColor;
  int? grupId;

  init(GrupPelanggan grupPelanggan) {
    grupId = grupPelanggan.id;
    selectedListKontak = grupPelanggan.contacts;
    selectedListKontakTemp = grupPelanggan.contacts;
    groupNameController.text = grupPelanggan.name;
    hexColorController.text = grupPelanggan.color.toHex();
    selectedColor = grupPelanggan.color;
    selectedTempColor = grupPelanggan.color;
    emit(EditGrupPelangganChangeState());
  }

  void addOrRemoveSelectedData(KontakPelanggan data, bool isNeedtoAdd) {
    if (isNeedtoAdd) {
      selectedListKontak.add(data);
    } else {
      selectedListKontak.remove(data);
    }
    emit(EditGrupPelangganChangeState());
  }

  void addOrRemoveSelectedDataTemp(KontakPelanggan data, bool isNeedtoAdd) {
    if (isNeedtoAdd) {
      selectedListKontakTemp.add(data);
    } else {
      selectedListKontakTemp.remove(data);
    }
    emit(EditGrupPelangganChangeState());
  }

  bool isDataExist(KontakPelanggan data) {
    if (selectedListKontak.contains(data)) {
      return true;
    }
    return false;
  }

  bool isDataTempExist(KontakPelanggan data) {
    if (selectedListKontakTemp.contains(data)) {
      return true;
    }
    return false;
  }

  void removeSelectedData(KontakPelanggan data) {
    selectedListKontak.remove(data);
    emit(EditGrupPelangganChangeState());
  }

  // Component GroupDetail
  // ValueChanged<Color> callback

  void changeTempColor(Color color) {
    selectedTempColor = color;
  }

  void changeColor() {
    selectedColor = selectedTempColor;
    hexColorController.text =
        '#${selectedTempColor.toString().split("0x")[1].replaceAll(")", "")}';
    selectedTempColor = null;
    emit(EditGrupPelangganChangeState());
  }

  void changeColorFromText() {
    Color color = HexColor.fromHex(hexColorController.text);
    selectedColor = color;
    emit(EditGrupPelangganChangeState());
  }

  grup.GrupPelanggan createObj() {
    return grup.GrupPelanggan(
      name: groupNameController.text,
      contacts: selectedListKontak,
      color: selectedColor!,
      created: 100,
      id: grupId,
    );
  }
}
