import 'package:equatable/equatable.dart';

abstract class CreateGrupPelangganState extends Equatable {
  final int time;

  CreateGrupPelangganState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class CreateGrupPelangganInitial extends CreateGrupPelangganState {}

class CreateGrupPelangganLoading extends CreateGrupPelangganState {}

class CreateGrupPelangganLoaded extends CreateGrupPelangganState {}

class CreateGrupPelangganChangeState extends CreateGrupPelangganState {}
