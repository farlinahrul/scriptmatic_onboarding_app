import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class GrupPelangganScreen extends StatelessWidget {
  const GrupPelangganScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Grup Pelanggan"),
      backgroundColor: PaletteColor.white,
      body: Center(
        child: Text("Grup Pelanggan"),
      ),
    );
  }
}
