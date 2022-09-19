import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/sinkronisasi_kontak/sinkronisasi_kontak_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/sinkronisasi_kontak/sinkronisasi_kontak_state.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/indicator_loader%20copy.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';

import 'import_kontak_screen.dart';

class SinkronisasiKontakScreen extends StatelessWidget {
  SinkronisasiKontakScreen({Key? key}) : super(key: key);

  late SinkronisasiKontakBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = context.read<SinkronisasiKontakBloc>();
    return Scaffold(
      appBar: const CustomAppBar(title: "Sinkronisasi Kontak"),
      body: BlocBuilder<SinkronisasiKontakBloc, SinkronisasiKontakState>(
        builder: (context, state) {
          if (state is SinkronisasiKontakLoading) {
            return indicatorLoader();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                const TextInter(
                  text: "Sinkronisasi Kontak Pelanggan",
                  size: 16,
                  fontWeight: Weightenum.semiBold,
                ),
                const SizedBox(
                  height: 4,
                ),
                const TextInter(
                  text: "Tambahkan kontak pelanggan secara otomatis.",
                  size: 14,
                  fontWeight: Weightenum.regular,
                ),
                const SizedBox(
                  height: 24,
                ),
                PrimaryButton(
                  title: "Sinkronisasikan Kontak",
                  onPressed: () {
                    _bloc.fetchData(() =>
                        RouteApp.pushScreen(context, ImportKontakScreen()));
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
