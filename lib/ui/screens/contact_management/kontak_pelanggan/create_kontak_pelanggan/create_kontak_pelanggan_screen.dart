import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiselect/multiselect.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/create_kontak_pelanggan/create_kontak_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/create_kontak_pelanggan/create_kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_input_field_with_icon.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class CreateKontakPelangganScreen extends StatelessWidget {
  CreateKontakPelangganScreen({Key? key}) : super(key: key);

  final CreateKontakPelangganBloc _bloc = CreateKontakPelangganBloc()..init();

  @override
  Widget build(BuildContext context) {
    final KontakPelangganBloc _blocKontakPelanggan =
        BlocProvider.of<KontakPelangganBloc>(context);
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Kontak Baru",
        ),
        body:
            BlocBuilder<CreateKontakPelangganBloc, CreateKontakPelangganState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      FormWithLabel(
                        controller: _bloc.nameController,
                        label: "Name",
                        labelText: "Masukan Nama",
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      FormWithLabel(
                        controller: _bloc.handphoneController,
                        label: "Nomer Telepon",
                        labelText: "Masukan Nomer Telepon",
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const TextInter(
                        text: "Group Pelanggan",
                        size: 14,
                        fontWeight: Weightenum.bold,
                      ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      DropDownMultiSelect(
                        isDense: true,
                        whenEmpty: "Pilih Group Pelanggan",
                        onChanged: (val) {
                          debugPrint("changed");
                          _bloc.setSelectedList();
                        },
                        selectedValues: _bloc.dummyListGroup.isNotEmpty
                            ? _bloc.selectedListGroup
                            : [],
                        options: _bloc.dummyListGroup.isNotEmpty
                            ? _bloc.dummyListGroup
                            : ["Group tidak tersedia"],
                        childBuilder: (selectedValues) {
                          return Align(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: TextInter(
                                text: selectedValues.isNotEmpty
                                    ? 'Terpilih (${selectedValues.length})'
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
                              color: _bloc.selectedListGroup.contains(str)
                                  ? PaletteColor.grey20
                                  : PaletteColor.white,
                            ),
                            child: TextInter(
                              text: str,
                              size: 14,
                              fontWeight: Weightenum.regular,
                              color: _bloc.selectedListGroup.contains(str)
                                  ? PaletteColor.textPrimary
                                  : PaletteColor.textSecondary1,
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: PaletteColor.borderEmphasis),
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
                            borderSide: const BorderSide(
                                color: PaletteColor.primary, width: 1.0),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          // contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      if (_bloc.selectedListGroup.isNotEmpty)
                        TextInter(
                          text: _bloc.selectedListGroup
                              .reduce((a, b) => a + ', ' + b),
                          size: 10,
                          fontWeight: Weightenum.semiBold,
                          color: PaletteColor.textGrey,
                          maxLines: 2,
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: PaletteColor.white,
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 12, top: 12),
                    child: const PrimaryButton(
                      enabled: false,
                      title: "Simpan",
                    ),
                  ),
                )
              ],
            );
          },
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
    required this.controller,
  }) : super(key: key);

  final String label;
  final String labelText;
  final TextEditingController controller;

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
          controller: controller,
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
