import 'package:equatable/equatable.dart';

abstract class CreateKontakPelangganState extends Equatable {
  final int time;

  CreateKontakPelangganState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class CreateKontakPelangganInitial extends CreateKontakPelangganState {}

class CreateKontakPelangganLoading extends CreateKontakPelangganState {}

class CreateKontakPelangganLoaded extends CreateKontakPelangganState {}

class CreateKontakPelangganChangeState extends CreateKontakPelangganState {}
