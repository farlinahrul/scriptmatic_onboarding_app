import 'package:equatable/equatable.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

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

