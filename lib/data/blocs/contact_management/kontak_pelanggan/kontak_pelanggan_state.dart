import 'package:equatable/equatable.dart';

import '../../../../models/kontak_pelanggan.dart';
import 'kontak_pelanggan_bloc.dart';

abstract class KontakPelangganState extends Equatable {
  final int time;

  KontakPelangganState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class KontakPelangganInitial extends KontakPelangganState {}

class KontakPelangganLoading extends KontakPelangganState {}

class KontakPelangganLoaded extends KontakPelangganState {
  final List<KontakPelanggan> data;

  KontakPelangganLoaded(this.data);
}

class KontakPelangganChangeState extends KontakPelangganState {}

class KontakPelangganLoadedWithFilterState extends KontakPelangganState {
  final List<KontakPelanggan> data;

  KontakPelangganLoadedWithFilterState(this.data);
}

