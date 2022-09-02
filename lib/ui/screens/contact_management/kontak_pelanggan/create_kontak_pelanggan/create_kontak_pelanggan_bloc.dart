import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/create_kontak_pelanggan/create_kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

class CreateKontakPelangganBloc extends Cubit<CreateKontakPelangganState> {
  CreateKontakPelangganBloc() : super(CreateKontakPelangganInitial());

  // final List<String> dummyListGroup = [];
  final List<String> dummyListGroup =
      GrupPelanggan.values.map((e) => e.value).toList();

  List<String> selectedListGroup = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController handphoneController = TextEditingController();

  /*  For Backend Component  */
  void init() {
    emit(CreateKontakPelangganLoaded());
    // emit(KontakPelangganLoaded([]));
  }

  setSelectedList() {
    emit(CreateKontakPelangganChangeState());
  }
}
