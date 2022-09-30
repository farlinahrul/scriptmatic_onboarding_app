/* Temporary data. Just for UI but may be used for logic */
import 'grup_pelanggan.dart';

class KontakPelanggan {
  int? id;
  final String name, number;
  final List<GrupPelanggan> types;
  // it must be DateTime
  final int created;

  KontakPelanggan({
    required this.name,
    required this.number,
    required this.types,
    required this.created,
    this.id,
  });
}