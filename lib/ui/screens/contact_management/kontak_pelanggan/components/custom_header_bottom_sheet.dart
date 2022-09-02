import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class CustomHeaderBottomSheet extends StatelessWidget {
  const CustomHeaderBottomSheet({
    Key? key,
    this.onClear,
    required this.title,
  }) : super(key: key);

  final Function()? onClear;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            RouteApp.popScreen(context);
          },
          child: const TextInter(
            text: "Cancel",
            size: 14,
            fontWeight: Weightenum.semiBold,
            color: PaletteColor.primary,
          ),
        ),
        TextInter(
          text: title,
          size: 18,
          fontWeight: Weightenum.semiBold,
        ),
        GestureDetector(
          onTap: () {
            onClear;
          },
          child: const TextInter(
            text: "Clear All",
            size: 14,
            fontWeight: Weightenum.semiBold,
            color: PaletteColor.primary,
          ),
        ),
      ],
    );
  }
}
