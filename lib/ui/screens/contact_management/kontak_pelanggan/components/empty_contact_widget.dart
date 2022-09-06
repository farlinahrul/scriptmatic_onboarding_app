import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_small_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class EmptyContactWidget extends StatelessWidget {
  const EmptyContactWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImagePaths.emptyList,
            width: MediaQuery.of(context).size.width / 2.2,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 24,
          ),
          const TextInter(
            text: "Kontak Kosong",
            size: 16,
            fontWeight: Weightenum.bold,
          ),
          const SizedBox(
            height: 4,
          ),
          const TextInter(
            text: "Silahkan tambahkan kontak terlebih dahulu",
            size: 14,
            fontWeight: Weightenum.regular,
            color: PaletteColor.black80,
          ),
          const SizedBox(
            height: 24,
          ),
          const Flexible(
            child: PrimarySmallButton(
              title: "Sinkronisasikan Kontak",
            ),
          )
        ],
      ),
    );
  }
}
