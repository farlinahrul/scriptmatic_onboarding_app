import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data/blocs/contact_management/grup_pelanggan/create_grup/create_grup_pelanggan_bloc.dart';
import 'data/blocs/contact_management/grup_pelanggan/grup_pelanggan_bloc.dart';
import 'data/blocs/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import 'data/blocs/contact_management/kontak_pelanggan/sinkronisasi_kontak/sinkronisasi_kontak_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/screens.dart';

void main() async {
  await initializeDateFormatting('in_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KontakPelangganBloc>(
          create: (context) => KontakPelangganBloc(),
        ),
        BlocProvider<GrupPelangganBloc>(
          create: (context) => GrupPelangganBloc(),
        ),
        BlocProvider<CreateGrupPelangganBloc>(
          create: (context) => CreateGrupPelangganBloc(),
        ),
        BlocProvider<SinkronisasiKontakBloc>(
          create: (context) => SinkronisasiKontakBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'Scriptmatic App',
        home: SplashScreen(),
      ),
    );
  }
}
