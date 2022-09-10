import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';

import 'grup_pelanggan_state.dart';

class GrupPelangganBloc extends Cubit<GrupPelangganState> {
  GrupPelangganBloc() : super(GrupPelangganInitial());

  // final List<String> listgroup =
  //     GrupPelanggan.values.map((e) => e.value).toList();
  final List<String> listSort = Sort.values.map((e) => e.value).toList();
  final TextEditingController searchController = TextEditingController();

  List<String> selectedGroupFilter = [];
  String? selectedSort;

  final List<GrupPelanggan> _dummyListKontak = [];

  /*  For Backend Component  */
  void init() {
    emit(GrupPelangganLoaded(_dummyListKontak));
    // emit(GrupPelangganLoaded([]));
  }

  void addContact(GrupPelanggan obj) {
    _dummyListKontak.add(obj);
    init();
  }

  void editContact(GrupPelanggan obj) {
    for (var i = 0; i < _dummyListKontak.length; i++) {
      if (_dummyListKontak[i].id == obj.id) {
        _dummyListKontak[i] = obj;
        init();
        return;
      }
    }
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
    return _dummyListKontak.length;
  }

  List<GrupPelanggan> _sortList(List<GrupPelanggan> dataList) {
    if (selectedSort == null) {
      return dataList;
    }
    // dataList.sort(Sort.values
    //     .firstWhere((element) => element.value == selectedSort!)
    //     .logicKontak);
    return dataList;
  }

  List<GrupPelanggan> _filterList(List<GrupPelanggan> dataList) {
    if (selectedGroupFilter.isEmpty) {
      return dataList;
    }
    for (var element in dataList) {
      // for (var type in element.types) {
      //   if (selectedGroupFilter.contains(type.value)) {
      //     dataList.add(element);
      //     break;
      //   }
      // }
    }
    return dataList;
  }

  List<GrupPelanggan> _searchList(List<GrupPelanggan> dataList) {
    dataList = _dummyListKontak
        .where((element) => element.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    return dataList;
  }

  void sortFilterAndSearch() {
    List<GrupPelanggan> listFinal = _dummyListKontak;
    listFinal = _searchList(listFinal);
    listFinal = _filterList(listFinal);
    listFinal = _sortList(listFinal);
    if (selectedGroupFilter.isEmpty && searchController.text.isEmpty) {
      emit(GrupPelangganLoaded(listFinal));
    } else {
      emit(GrupPelangganLoadedWithFilterState(listFinal));
    }
  }
}

class GrupPelanggan {
  final int id, created;
  final String name;
  final Color color;

  GrupPelanggan({
    required this.name,
    required this.color,
    required this.id,
    required this.created,
  });
}
