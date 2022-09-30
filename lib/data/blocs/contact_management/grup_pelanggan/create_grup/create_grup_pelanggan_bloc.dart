import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/utils/hex_color.dart';

import '../../../../../../models/grup_pelanggan.dart';
import '../../../../../../models/kontak_pelanggan.dart';
import 'create_grup_pelanggan_state.dart';

class CreateGrupPelangganBloc extends Cubit<CreateGrupPelangganState> {
  CreateGrupPelangganBloc() : super(CreateGrupPelangganInitial());

  List<KontakPelanggan> selectedListKontak = [];
  List<KontakPelanggan> selectedListKontakTemp = [];

  // Component GroupDetail
  TextEditingController groupNameController = TextEditingController();
  TextEditingController hexColorController = TextEditingController();
  Color? selectedColor;
  Color? selectedTempColor;

  void init() {
    selectedListKontak = [];
    selectedListKontakTemp = [];
    groupNameController = TextEditingController();
    hexColorController = TextEditingController();
    selectedColor;
    selectedTempColor;
  }

  void addOrRemoveSelectedData(KontakPelanggan data, bool isNeedtoAdd) {
    if (isNeedtoAdd) {
      selectedListKontak.add(data);
    } else {
      selectedListKontak.remove(data);
    }
    emit(CreateGrupPelangganChangeState());
  }

  void addOrRemoveSelectedDataTemp(KontakPelanggan data, bool isNeedtoAdd) {
    if (isNeedtoAdd) {
      selectedListKontakTemp.add(data);
    } else {
      selectedListKontakTemp.remove(data);
    }
    emit(CreateGrupPelangganChangeState());
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
    emit(CreateGrupPelangganChangeState());
  }

  // Component GroupDetail
  // ValueChanged<Color> callback
  void initDetail() {
    selectedListKontak = [...selectedListKontakTemp];
  }

  void changeTempColor(Color color) {
    selectedTempColor = color;
  }

  void changeColor() {
    selectedColor = selectedTempColor;
    hexColorController.text =
        '#${selectedTempColor.toString().split("0x")[1].replaceAll(")", "")}';
    selectedTempColor = null;
    emit(CreateGrupPelangganChangeState());
  }

  void changeColorFromText() {
    Color color = HexColor.fromHex(hexColorController.text);
    selectedColor = color;
    emit(CreateGrupPelangganChangeState());
  }

  GrupPelanggan createObj() {
    return GrupPelanggan(
      name: groupNameController.text,
      contacts: selectedListKontak,
      color: selectedColor!,
      created: 100,
      id: 1,
    );
  }
}
