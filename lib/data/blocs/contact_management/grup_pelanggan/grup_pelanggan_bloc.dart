import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

import '../../../../../models/grup_pelanggan.dart';
import 'grup_pelanggan_state.dart';

class GrupPelangganBloc extends Cubit<GrupPelangganState> {
  GrupPelangganBloc() : super(GrupPelangganInitial());

  final List<GrupPelanggan> dummyListGrup = [
    GrupPelanggan(
      name: "Loyal Customer",
      contacts: [],
      color: PaletteColor.yellow,
      id: 1,
      created: 1,
    ),
    GrupPelanggan(
      name: "Returning Customer",
      contacts: [],
      color: PaletteColor.blue,
      id: 2,
      created: 2,
    ),
    GrupPelanggan(
      name: "Shopee",
      contacts: [],
      color: PaletteColor.orange,
      id: 3,
      created: 3,
    ),
    GrupPelanggan(
      name: "New Customer",
      contacts: [],
      color: PaletteColor.red,
      id: 4,
      created: 4,
    ),
    GrupPelanggan(
      name: "Tokopedia",
      contacts: [],
      color: PaletteColor.green,
      id: 5,
      created: 5,
    ),
    GrupPelanggan(
      name: "Men Wear",
      contacts: [],
      color: PaletteColor.violet,
      id: 6,
      created: 6,
    ),
  ];

  // final List<String> listgroup =
  //     GrupPelanggan.values.map((e) => e.value).toList();
  final List<String> listSort = Sort.values.map((e) => e.value).toList();
  final TextEditingController searchController = TextEditingController();

  List<String> selectedGroupFilter = [];
  String? selectedSort;

  /*  For Backend Component  */
  void init() {
    emit(GrupPelangganLoaded(dummyListGrup));
    // emit(GrupPelangganLoaded([]));
  }

  void setSelectedGroupFilter(final bool selected, final String value) {
    if (selected) {
      selectedGroupFilter.add(value);
    } else {
      selectedGroupFilter.remove(value);
    }
  }

  void setSelectedSort(final bool selected, final String value) {
    if (selected) {
      selectedSort = value;
    } else {
      selectedSort = null;
    }
  }

  void clearSort() {
    selectedSort = null;
  }

  void clearFilter() {
    selectedGroupFilter = [];
  }

  int countList() {
    return dummyListGrup.length;
  }

  List<GrupPelanggan> _sortList(List<GrupPelanggan> dataList) {
    if (selectedSort == null) {
      return dataList;
    }
    dataList.sort(Sort.values
        .firstWhere((element) => element.value == selectedSort!)
        .logicGrup);
    return dataList;
  }

  List<GrupPelanggan> _filterList(List<GrupPelanggan> dataList) {
    if (selectedGroupFilter.isEmpty) {
      return dataList;
    }
    // for (var element in dataList) {
    //   for (var type in element.types) {
    //     if (selectedGroupFilter.contains(type.value)) {
    //       dataList.add(element);
    //       break;
    //     }
    //   }
    // }
    return dataList;
  }

  List<GrupPelanggan> _searchList(List<GrupPelanggan> dataList) {
    dataList = dummyListGrup
        .where((element) => element.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    return dataList;
  }

  void sortFilterAndSearch() {
    List<GrupPelanggan> listFinal = dummyListGrup;
    listFinal = _searchList(listFinal);
    listFinal = _filterList(listFinal);
    listFinal = _sortList(listFinal);
    if (selectedGroupFilter.isEmpty && searchController.text.isEmpty) {
      emit(GrupPelangganLoaded(listFinal));
    } else {
      emit(GrupPelangganLoadedWithFilterState(listFinal));
    }
  }

  void addData(GrupPelanggan data) {
    data.id = dummyListGrup.length + 1;
    dummyListGrup.add(data);
    init();
  }

  void editGrup(GrupPelanggan obj) {
    for (var i = 0; i < dummyListGrup.length; i++) {
      if (dummyListGrup[i].id == obj.id) {
        dummyListGrup[i] = obj;
        init();
        return;
      }
    }
  }
}


