import 'package:equatable/equatable.dart';

abstract class SinkronisasiKontakState extends Equatable {
  final int time;

  SinkronisasiKontakState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class SinkronisasiKontakInitial extends SinkronisasiKontakState {}

class SinkronisasiKontakLoading extends SinkronisasiKontakState {}

class SinkronisasiKontakError extends SinkronisasiKontakState {}

class SinkronisasiKontakLoaded extends SinkronisasiKontakState {}

class SinkronisasiKontakChangeState extends SinkronisasiKontakState {}

class SinkronisasiKontakLoadedWithFilterState extends SinkronisasiKontakState {
  // final List<SinkronisasiKontak> data;

  // SinkronisasiKontakLoadedWithFilterState(this.data);
}
