import 'package:equatable/equatable.dart';

abstract class EditGrupPelangganState extends Equatable {
  final int time;

  EditGrupPelangganState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class EditGrupPelangganInitial extends EditGrupPelangganState {}

class EditGrupPelangganLoading extends EditGrupPelangganState {}

class EditGrupPelangganLoaded extends EditGrupPelangganState {}

class EditGrupPelangganChangeState extends EditGrupPelangganState {}
