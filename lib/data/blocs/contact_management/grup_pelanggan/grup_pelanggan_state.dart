import 'package:equatable/equatable.dart';

import '../../../../../models/grup_pelanggan.dart';
import 'grup_pelanggan_bloc.dart';

abstract class GrupPelangganState extends Equatable {
  final int time;

  GrupPelangganState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class GrupPelangganInitial extends GrupPelangganState {}

class GrupPelangganLoading extends GrupPelangganState {}

class GrupPelangganLoaded extends GrupPelangganState {
  final List<GrupPelanggan> data;

  GrupPelangganLoaded(this.data);
}

class GrupPelangganChangeState extends GrupPelangganState {}

class GrupPelangganLoadedWithFilterState extends GrupPelangganState {
  final List<GrupPelanggan> data;

  GrupPelangganLoadedWithFilterState(this.data);
}

