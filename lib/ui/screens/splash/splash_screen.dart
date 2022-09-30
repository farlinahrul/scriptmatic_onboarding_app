import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/onboarding/onboarding_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    return Timer(const Duration(seconds: 1, milliseconds: 30), () {
      RouteApp.pushScreen(context, const OnboardingScreen());
    });
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [PaletteColor.primaryDark, PaletteColor.primary60],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImagePaths.imgLogoScriptmatic,
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.fitWidth,
                ),
                const TextInter(
                  text: "Scriptmatic",
                  size: 32,
                  fontWeight: Weightenum.semiBold,
                  color: PaletteColor.textPrimaryInverted,
                ),
                const TextInter(
                  text: "Generate Script Just One Click",
                  size: 16,
                  fontWeight: Weightenum.medium,
                  color: PaletteColor.textPrimaryInverted,
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Image.asset(
                      AppImagePaths.imgSplash,
                      width: MediaQuery.of(context).size.width / 1,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
