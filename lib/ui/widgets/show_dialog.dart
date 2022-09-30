import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class ShowDialog extends StatelessWidget {
  final String title;
  final String description;
  final String negativeTitle;
  final String positiveTitle;
  final Function negativeAction;
  final Function positiveAction;
  final bool isPositiveActionDanger;

  const ShowDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.negativeTitle,
    required this.positiveTitle,
    required this.negativeAction,
    required this.positiveAction,
    this.isPositiveActionDanger = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   title,
            //   textAlign: TextAlign.center,
            //   style: TypographyStyle.subtitle1.copyWith(
            //     color: PaletteColor.black,
            //   ),
            // ),
            TextInter(
              text: title,
              align: TextAlign.center,
              fontWeight: Weightenum.bold,
              size: 18,
            ),
            const SizedBox(height: 16),
            // Text(
            //   description,
            //   textAlign: TextAlign.center,
            //   style: TypographyStyle.caption1.copyWith(
            //     color: PaletteColor.black,
            //   ),
            // ),
            TextInter(
              text: description,
              align: TextAlign.center,
              fontWeight: Weightenum.regular,
              size: 14,
              maxLines: 5,
              color: PaletteColor.textGrey,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     positiveAction.call();
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: isPositiveActionDanger
                  //         ? PaletteColor.red
                  //         : PaletteColor.primary,
                  //     elevation: 0,
                  //   ),
                  //   // child: Text(
                  //   //   positiveTitle,
                  //   //   style: TypographyStyle.button2.copyWith(
                  //   //     color: Colors.white,
                  //   //   ),
                  //   // ),
                  //   child: TextInter(
                  //     text: positiveTitle,
                  //     fontWeight: Weightenum.regular,
                  //     size: 14,
                  //   ),
                  // ),
                  child: PrimaryButton(
                    title: positiveTitle,
                    shadowed: false,
                    onPressed: () {
                      positiveAction.call();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     negativeAction.call();
                  //   },
                  //   // style: ElevatedButton.styleFrom(
                  //   //   primary: PaletteColor.grey40,
                  //   //   elevation: 0,
                  //   // ),
                  //   // child: Text(
                  //   //   negativeTitle,
                  //   //   style: TypographyStyle.button2.copyWith(
                  //   //     color: PaletteColor.grey80,
                  //   //   ),
                  //   // ),
                  //   child: TextInter(
                  //     text: negativeTitle,
                  //     fontWeight: Weightenum.regular,
                  //     size: 14,
                  //   ),
                  // ),
                  child: PrimaryButton(
                    title: negativeTitle,
                    isSolid: false,
                    shadowed: false,
                    onPressed: () {
                      negativeAction.call();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
