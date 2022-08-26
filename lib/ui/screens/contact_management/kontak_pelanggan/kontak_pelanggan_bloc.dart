import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class KontakPelangganBloc extends Cubit<KontakPelangganState> {
  KontakPelangganBloc() : super(KontakPelangganInitial());

  final List<KontakPelanggan> _dummyListKontak = [
    KontakPelanggan(
      name: "Brad Simmons",
      number: "0893452887643",
      type: GrupPelanggan.loyalCustomer,
    ),
    KontakPelanggan(
      name: "Farli Nahrul",
      number: "089300871672",
      type: GrupPelanggan.newCustomer,
    ),
    KontakPelanggan(
      name: "Javier Nahrul",
      number: "089312785628",
      type: GrupPelanggan.returningCustomer,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.shopee,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.menWear,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
    KontakPelanggan(
      name: "Nahrul Farli",
      number: "082251641111",
      type: GrupPelanggan.tokopedia,
    ),
  ];

  /*  For Backend Component  */
  void init() {
    emit(KontakPelangganLoaded(_dummyListKontak));
    // emit(KontakPelangganLoaded([]));
  }
}

class KontakPelanggan {
  final String name, number;
  final GrupPelanggan type;

  KontakPelanggan({
    required this.name,
    required this.number,
    required this.type,
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
