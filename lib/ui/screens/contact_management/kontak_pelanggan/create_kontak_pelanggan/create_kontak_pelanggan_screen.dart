import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect/multiselect.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_multiselect_dropdown.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_input_field_with_icon.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class CreateKontakPelangganScreen extends StatelessWidget {
  const CreateKontakPelangganScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Kontak Baru",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            FormWithLabel(
              label: "Name",
              labelText: "Masukan Nama",
            ),
            SizedBox(
              height: 14,
            ),
            FormWithLabel(
              label: "Nomer Telepon",
              labelText: "Masukan Nomer Telepon",
            ),
            SizedBox(
              height: 14,
            ),
            DropdownButton<String>(
              isExpanded: true,
              focusColor: Colors.white,
              value: "Android",
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: <String>[
                'Android',
                'IOS',
                'Flutter',
                'Node',
                'Java',
                'Python',
                'PHP',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
              hint: Text(
                "Please choose a langauage",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String? value) {
                // setState(() {
                //   _chosenValue = value;
                // });
              },
            ),
            DropDownMultiSelect(
              isDense: true,
              whenEmpty: "Pilih Group Pelanggan",
              onChanged: (val) {},
              selectedValues: const [],
              options: [
                "Farli",
                "Nahrul",
                "Javier",
              ],
              childBuilder: (selectedValues) {
                return Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: TextInter(
                      text: selectedValues.isNotEmpty
                          ? selectedValues.reduce((a, b) => a + ' , ' + b)
                          : 'Pilih Group Pelanggan',
                      size: 14,
                      fontWeight: Weightenum.regular,
                      color: selectedValues.isNotEmpty
                          ? PaletteColor.textPrimary
                          : PaletteColor.textSecondary2,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                );
              },
              menuItembuilder: (str) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 16,
                    bottom: 16,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PaletteColor.grey20,
                  ),
                  child: TextInter(
                    text: str,
                    size: 14,
                    fontWeight: Weightenum.regular,
                  ),
                );
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: PaletteColor.borderEmphasis),
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: false,
                fillColor: PaletteColor.bgSecondary,
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: PaletteColor.textSecondary2,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: PaletteColor.primary, width: 1.0),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FormWithLabel extends StatelessWidget {
  const FormWithLabel({
    Key? key,
    required this.label,
    required this.labelText,
  }) : super(key: key);

  final String label;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInter(
          text: label,
          size: 14,
          fontWeight: Weightenum.bold,
        ),
        const SizedBox(
          height: 12,
        ),
        FormInputFieldWithIcon(
          borderRadius: 14,
          controller: null,
          iconSuffix: null,
          labelText: labelText,
          onChanged: (val) {},
          onSaved: (val) {},
          onTap: () {},
          validator: null,
        ),
      ],
    );
  }
}
