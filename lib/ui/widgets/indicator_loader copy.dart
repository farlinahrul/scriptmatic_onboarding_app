import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';


Widget indicatorLoader({double size = 45}) {
  return SpinKitFadingCircle(
    size: size,
    itemBuilder: (BuildContext context, int index) {
      return const DecoratedBox(
        decoration: BoxDecoration(
          color: PaletteColor.primary,
          shape: BoxShape.circle,
        ),
      );
    },
  );
}
