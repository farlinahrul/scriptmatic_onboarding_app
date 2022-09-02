import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_state.dart';
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

  final List<KontakPelanggan> _dummyListKontak = [
    KontakPelanggan(
      name: "Brad Simmons",
      number: "0893452887643",
      type: GrupPelanggan.loyalCustomer,
      created: 1,
    ),
    KontakPelanggan(
      name: "Farli Nahrul",
      number: "089300871672",
      type: GrupPelanggan.newCustomer,
      created: 2,
    ),
    KontakPelanggan(
      name: "Javier Nahrul",
      number: "089312785628",
      type: GrupPelanggan.returningCustomer,
      created: 3,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.shopee,
      created: 4,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 5,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 7,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 8,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 9,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 10,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 11,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 12,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
      created: 13,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.menWear,
      created: 6,
    ),
    KontakPelanggan(
      name: "Alpha",
      number: "082251641111",
      type: GrupPelanggan.menWear,
      created: 13,
    ),
    KontakPelanggan(
      name: "Beta",
      number: "082251641111",
      type: GrupPelanggan.shopee,
      created: 13,
    ),
    KontakPelanggan(
      name: "Cicak",
      number: "082251641111",
      type: GrupPelanggan.loyalCustomer,
      created: 13,
    ),
  ];

  /*  For Backend Component  */
  void init() {
    emit(KontakPelangganLoaded(_dummyListKontak));
    // emit(KontakPelangganLoaded([]));
  }

  void addContact() {}

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

  List<KontakPelanggan> _sortList(List<KontakPelanggan> dataList) {
    if (selectedSort == null) {
      return dataList;
    }
    dataList.sort(Sort.values
        .firstWhere((element) => element.value == selectedSort!)
        .logic);
    return dataList;
  }

  List<KontakPelanggan> _filterList(List<KontakPelanggan> dataList) {
    if (selectedGroupFilter.isEmpty) {
      return dataList;
    }
    return dataList
        .where((element) => selectedGroupFilter.contains(element.type.value))
        .toList();
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
  final String name, number;
  final GrupPelanggan type;
  // it must be DateTime
  final int created;

  KontakPelanggan({
    required this.name,
    required this.number,
    required this.type,
    required this.created,
  });
}

enum Sort {
  oldestOnTop,
  newestOnTop,
  nameDescending,
  nameAscending,
}

extension SortExt on Sort {
  static const Map<Sort, String> values = {
    Sort.oldestOnTop: "OLDEST ON TOP",
    Sort.newestOnTop: "NEWEST ON TOP",
    Sort.nameDescending: "NAME DESCENDING",
    Sort.nameAscending: "NAME ASCENDING",
  };

  static Map<Sort, int Function(KontakPelanggan, KontakPelanggan)> logics = {
    Sort.oldestOnTop: (a, b) => a.created.compareTo(b.created),
    Sort.newestOnTop: (a, b) => b.created.compareTo(a.created),
    Sort.nameDescending: (a, b) => b.name.compareTo(a.name),
    Sort.nameAscending: (a, b) => a.name.compareTo(b.name),
  };

  String get value => values[this]!;
  int Function(KontakPelanggan, KontakPelanggan) get logic => logics[this]!;
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
