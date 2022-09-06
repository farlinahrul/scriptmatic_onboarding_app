import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.name,
    required this.number,
    required this.types,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String number;
  final List<GrupPelanggan> types;
  final void Function() onTap;

  List<Widget> generateWidgets() {
    return types
        .map((e) => TextInter(
              text: '${e.value} ',
              size: 13,
              fontWeight: Weightenum.bold,
              color: e.color,
            ))
        .toList();
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
                ),
                const SizedBox(
                  height: 3,
                ),
                TextInter(
                  text: number,
                  size: 13,
                  fontWeight: Weightenum.medium,
                  color: PaletteColor.textSecondary2,
                ),
                const SizedBox(
                  height: 3,
                ),
                Wrap(
                  children: generateWidgets(),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Ink(
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
            ),
          )
        ],
      ),
    );
  }
}
