import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class GrupTile extends StatelessWidget {
  const GrupTile({
    Key? key,
    required this.name,
    required this.countContacts,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final String name;
  final int countContacts;
  final Color color;
  final void Function() onTap;

  List<Widget> addSeparatorOnListWidget(
      List<Widget> widgets, Widget separator) {
    List<Widget> joined = [];

    for (var i = 0; i < widgets.length; i++) {
      if (i != widgets.length - 1) {
        joined.add(widgets[i]);
        joined.add(separator);
      } else {
        joined.add(widgets[i]);
      }
    }
    return joined;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInter(
                  text: name,
                  size: 16,
                  fontWeight: Weightenum.bold,
                  color: color,
                ),
                const SizedBox(
                  height: 3,
                ),
                TextInter(
                  text: '$countContacts Peserta',
                  size: 13,
                  fontWeight: Weightenum.medium,
                  color: PaletteColor.textSecondary2,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: PaletteColor.grey20,
              ),
              child: Image.asset(
                AppImagePaths.editUser,
                width: 14,
                height: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
