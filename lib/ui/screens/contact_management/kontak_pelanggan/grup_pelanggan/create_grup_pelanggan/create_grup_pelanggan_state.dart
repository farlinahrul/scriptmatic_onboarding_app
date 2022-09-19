import 'package:equatable/equatable.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

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
