import 'package:equatable/equatable.dart';

abstract class EditKontakPelangganState extends Equatable {
  final int time;

  EditKontakPelangganState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class EditKontakPelangganInitial extends EditKontakPelangganState {}

class EditKontakPelangganLoading extends EditKontakPelangganState {}

class EditKontakPelangganLoaded extends EditKontakPelangganState {}

class EditKontakPelangganChangeState extends EditKontakPelangganState {}
