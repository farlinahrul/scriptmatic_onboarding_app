import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class KontakPelangganActionTile extends StatelessWidget {
  const KontakPelangganActionTile({
    Key? key,
    required this.text,
    required this.svgPath,
  }) : super(key: key);

  final String text;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: PaletteColor.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              svgPath,
              width: 22,
              height: 22,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        TextInter(
          text: text,
          size: 16,
          fontWeight: Weightenum.regular,
        )
      ],
    );
  }
}
