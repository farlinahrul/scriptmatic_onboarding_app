import 'package:equatable/equatable.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

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
