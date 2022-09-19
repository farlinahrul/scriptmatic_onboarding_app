import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/grup_pelanggan/grup_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

enum Weightenum {
  /// FontWeight 100.
  thin,

  /// FontWeight 300.
  light,

  /// FontWeight 400.
  regular,

  /// FontWeight 500.
  medium,

  /// FontWeight 600.
  semiBold,

  /// FontWeight 700.
  bold
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

  static Map<Sort, int Function(KontakPelanggan, KontakPelanggan)>
      logicsKontak = {
    Sort.oldestOnTop: (a, b) => a.created.compareTo(b.created),
    Sort.newestOnTop: (a, b) => b.created.compareTo(a.created),
    Sort.nameDescending: (a, b) =>
        b.name.toLowerCase().compareTo(a.name.toLowerCase()),
    Sort.nameAscending: (a, b) =>
        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
  };

  static Map<Sort, int Function(GrupPelanggan, GrupPelanggan)> logicsGrups = {
    Sort.oldestOnTop: (a, b) => a.created.compareTo(b.created),
    Sort.newestOnTop: (a, b) => b.created.compareTo(a.created),
    Sort.nameDescending: (a, b) =>
        b.name.toLowerCase().compareTo(a.name.toLowerCase()),
    Sort.nameAscending: (a, b) =>
        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
  };

  String get value => values[this]!;
  int Function(KontakPelanggan, KontakPelanggan) get logicKontak =>
      logicsKontak[this]!;
  int Function(GrupPelanggan, GrupPelanggan) get logicGrup =>
      logicsGrups[this]!;
}
