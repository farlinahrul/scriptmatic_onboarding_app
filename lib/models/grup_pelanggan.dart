import 'package:flutter/painting.dart';

import 'kontak_pelanggan.dart';

class GrupPelanggan {
  int? id;
  final int created;
  final String name;
  final Color color;
  // temporary
  final List<KontakPelanggan> contacts;

  GrupPelanggan({
    required this.name,
    required this.color,
    this.id,
    required this.created,
    required this.contacts,
  });
}