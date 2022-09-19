import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

import '../grup_pelanggan/grup_pelanggan_bloc.dart';

class ContactTileWithCheckbox extends StatefulWidget {
  ContactTileWithCheckbox({
    Key? key,
    required this.name,
    required this.number,
    this.types,
    required this.onTap,
    required this.onChanged,
    required this.isSelected,
  }) : super(key: key);

  final String name;
  final String number;
  bool isSelected;
  final List<GrupPelanggan>? types;
  final void Function() onTap;
  final void Function(bool?)? onChanged;

  @override
  State<ContactTileWithCheckbox> createState() =>
      _ContactTileWithCheckboxState();
}

class _ContactTileWithCheckboxState extends State<ContactTileWithCheckbox> {
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

  List<Widget> generateWidgets() {
    return widget.types!
        .map((e) => TextInter(
              text: e.name,
              size: 13,
              fontWeight: Weightenum.bold,
              color: e.color,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            widget.isSelected = !widget.isSelected;
            widget.onChanged!(widget.isSelected);
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: PaletteColor.textGrey,
                ),
                child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  checkColor: Colors.white,
                  activeColor: PaletteColor.primary,
                  value: widget.isSelected,
                  onChanged: widget.onChanged,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInter(
                    text: widget.name,
                    size: 16,
                    fontWeight: Weightenum.bold,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextInter(
                    text: widget.number,
                    size: 13,
                    fontWeight: Weightenum.medium,
                    color: PaletteColor.textSecondary2,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  if (widget.types != null)
                    Wrap(
                      children: addSeparatorOnListWidget(
                        generateWidgets(),
                        const TextInter(
                          text: ', ',
                          size: 13,
                          fontWeight: Weightenum.bold,
                          color: PaletteColor.textGrey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Material(
              child: InkWell(
                onTap: widget.onTap,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
