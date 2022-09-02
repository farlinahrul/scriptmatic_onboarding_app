import 'package:equatable/equatable.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

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
