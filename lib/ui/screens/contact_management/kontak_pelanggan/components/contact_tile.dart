import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.name,
    required this.number,
    required this.type,
    required this.color,
  }) : super(key: key);

  final String name;
  final String number;
  final String type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            TextInter(
              text: name,
              size: 14,
              fontWeight: Weightenum.bold,
            ),
            const SizedBox(
              height: 2,
            ),
            TextInter(
              text: number,
              size: 12,
              fontWeight: Weightenum.medium,
              color: PaletteColor.textSecondary2,
            ),
            const SizedBox(
              height: 2,
            ),
            TextInter(
              text: type,
              size: 12,
              fontWeight: Weightenum.bold,
              color: color,
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: PaletteColor.grey20,
          ),
          child: Image.asset(
            AppImagePaths.editUser,
            width: 16,
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }
}
