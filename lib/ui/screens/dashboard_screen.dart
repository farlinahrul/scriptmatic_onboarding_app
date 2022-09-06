import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/grup_pelanggan/grup_pelanggan_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Dashboard"),
      backgroundColor: PaletteColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryButton(
              title: "Kontak Pelanggan",
              onPressed: () {
                RouteApp.pushScreen(context, KontakPelangganScreen());
              },
            ),
            SizedBox(
              height: 24,
            ),
            PrimaryButton(
              title: "Grup Pelanggan",
              onPressed: () {
                RouteApp.pushScreen(context, GrupPelangganScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
