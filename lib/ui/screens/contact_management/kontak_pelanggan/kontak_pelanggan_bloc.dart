import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class KontakPelangganBloc extends Cubit<KontakPelangganState> {
  KontakPelangganBloc() : super(KontakPelangganInitial());

  final List<String> listgroup =
      GrupPelanggan.values.map((e) => e.value).toList();
  final List<String> listSort = Sort.values.map((e) => e.value).toList();
  final TextEditingController searchController = TextEditingController();

  List<String> selectedGroupFilter = [];
  String? selectedSort;

  final List<String> dummySugestionResult = [
    "Farli",
    "Nahrul",
    "Javier",
  ];

  // final List<KontakPelanggan> _dummyListKontak = [
  //   KontakPelanggan(
  //     id: 1,
  //     name: "Brad Simmons",
  //     number: "0893452887643",
  //     types: [
  //       GrupPelanggan.loyalCustomer,
  //       GrupPelanggan.tokopedia,
  //       GrupPelanggan.menWear,
  //       GrupPelanggan.shopee,
  //     ],
  //     created: 1,
  //   ),
  //   KontakPelanggan(
  //     id: 2,
  //     name: "Farli Nahrul",
  //     number: "089300871672",
  //     types: [GrupPelanggan.newCustomer],
  //     created: 2,
  //   ),
  //   KontakPelanggan(
  //     id: 3,
  //     name: "Javier Nahrul",
  //     number: "089312785628",
  //     types: [GrupPelanggan.returningCustomer],
  //     created: 3,
  //   ),
  //   KontakPelanggan(
  //     id: 4,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.shopee],
  //     created: 4,
  //   ),
  //   KontakPelanggan(
  //     id: 5,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 5,
  //   ),
  //   KontakPelanggan(
  //     id: 6,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 7,
  //   ),
  //   KontakPelanggan(
  //     id: 7,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 8,
  //   ),
  //   KontakPelanggan(
  //     id: 8,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 9,
  //   ),
  //   KontakPelanggan(
  //     id: 9,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 10,
  //   ),
  //   KontakPelanggan(
  //     id: 10,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 11,
  //   ),
  //   KontakPelanggan(
  //     id: 11,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 12,
  //   ),
  //   KontakPelanggan(
  //     id: 12,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.tokopedia],
  //     created: 13,
  //   ),
  //   KontakPelanggan(
  //     id: 13,
  //     name: "Nahrul Farli",
  //     number: "082251641111",
  //     types: [GrupPelanggan.menWear],
  //     created: 6,
  //   ),
  //   KontakPelanggan(
  //     id: 14,
  //     name: "Alpha",
  //     number: "082251641111",
  //     types: [GrupPelanggan.menWear],
  //     created: 13,
  //   ),
  //   KontakPelanggan(
  //     id: 15,
  //     name: "Beta",
  //     number: "082251641111",
  //     types: [GrupPelanggan.shopee],
  //     created: 13,
  //   ),
  //   KontakPelanggan(
  //     id: 16,
  //     name: "Cicak",
  //     number: "082251641111",
  //     types: [GrupPelanggan.loyalCustomer],
  //     created: 13,
  //   ),
  // ];

  final List<KontakPelanggan> _dummyListKontak = [];

  /*  For Backend Component  */
  void init() {
    emit(KontakPelangganLoaded(_dummyListKontak));
    // emit(KontakPelangganLoaded([]));
  }

  void addContact(KontakPelanggan obj) {
    _dummyListKontak.add(obj);
    init();
  }

  void editContact(KontakPelanggan obj) {
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

  List<KontakPelanggan> _sortList(List<KontakPelanggan> dataList) {
    if (selectedSort == null) {
      return dataList;
    }
    dataList.sort(Sort.values
        .firstWhere((element) => element.value == selectedSort!)
        .logicKontak);
    return dataList;
  }

  List<KontakPelanggan> _filterList(List<KontakPelanggan> dataList) {
    if (selectedGroupFilter.isEmpty) {
      return dataList;
    }
    for (var element in dataList) {
      for (var type in element.types) {
        if (selectedGroupFilter.contains(type.value)) {
          dataList.add(element);
          break;
        }
      }
    }
    return dataList;
  }

  List<KontakPelanggan> _searchList(List<KontakPelanggan> dataList) {
    dataList = _dummyListKontak
        .where((element) => element.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    return dataList;
  }

  void sortFilterAndSearch() {
    List<KontakPelanggan> listFinal = _dummyListKontak;
    listFinal = _searchList(listFinal);
    listFinal = _filterList(listFinal);
    listFinal = _sortList(listFinal);
    if (selectedGroupFilter.isEmpty && searchController.text.isEmpty) {
      emit(KontakPelangganLoaded(listFinal));
    } else {
      emit(KontakPelangganLoadedWithFilterState(listFinal));
    }
  }
}

/* Temporary data. Just for UI but may be used for logic */
class KontakPelanggan {
  final int id;
  final String name, number;
  final List<GrupPelanggan> types;
  // it must be DateTime
  final int created;

  KontakPelanggan({
    required this.name,
    required this.number,
    required this.types,
    required this.created,
    required this.id,
  });
}

enum GrupPelanggan {
  newCustomer,
  loyalCustomer,
  returningCustomer,
  tokopedia,
  shopee,
  menWear,
}

extension GrupPelangganExt on GrupPelanggan {
  // static const Map<GrupPelanggan, int> keys = {
  //   GrupPelanggan.newCustomer: 0,
  //   GrupPelanggan.shopee: 1,
  //   GrupPelanggan.loyalCustomer: 2,
  //   GrupPelanggan.returningCustomer: 3,
  // };

  static const Map<GrupPelanggan, String> values = {
    GrupPelanggan.newCustomer: "New Customer",
    GrupPelanggan.loyalCustomer: "Loyal Customer",
    GrupPelanggan.returningCustomer: "Returning Customer",
    GrupPelanggan.tokopedia: "Tokopedia",
    GrupPelanggan.shopee: "Shopee",
    GrupPelanggan.menWear: "Men Wear",
  };

  static const Map<GrupPelanggan, Color> colors = {
    GrupPelanggan.newCustomer: PaletteColor.red,
    GrupPelanggan.loyalCustomer: PaletteColor.yellow,
    GrupPelanggan.returningCustomer: PaletteColor.blue,
    GrupPelanggan.tokopedia: PaletteColor.green,
    GrupPelanggan.shopee: PaletteColor.orange,
    GrupPelanggan.menWear: PaletteColor.violet,
  };

  // int get key => keys[this]!;
  String get value => values[this]!;
  Color get color => colors[this]!;

  // static GrupPelanggan? fromRaw(int? raw) {
  //   try {
  //     return keys.entries.firstWhere((e) => e.value == raw).key;
  //   } catch (_) {
  //     return null;
  //   }
  // }
  static GrupPelanggan? fromRaw(String? raw) {
    try {
      return values.entries.firstWhere((e) => e.value == raw).key;
    } catch (_) {
      return null;
    }
  }
}
