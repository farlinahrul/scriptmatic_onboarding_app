import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_with_label_widget.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/multiselect.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';
import 'package:scriptmatic_onboarding_app/utils/validator.dart';

import '../../../../../data/blocs/contact_management/kontak_pelanggan/create_kontak/create_kontak_pelanggan_bloc.dart';
import '../../../../../data/blocs/contact_management/kontak_pelanggan/create_kontak/create_kontak_pelanggan_state.dart';
import '../../../../../data/blocs/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';

class CreateKontakPelangganScreen extends StatefulWidget {
  const CreateKontakPelangganScreen({Key? key}) : super(key: key);

  @override
  State<CreateKontakPelangganScreen> createState() =>
      _CreateKontakPelangganScreenState();
}

class _CreateKontakPelangganScreenState
    extends State<CreateKontakPelangganScreen> {
  late CreateKontakPelangganBloc _bloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bloc = CreateKontakPelangganBloc()..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        backgroundColor: PaletteColor.white,
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
                  child: Form(
                    key: _formKey,
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
                          validator: (val) {
                            String? notEmpty = Validator().notEmpty(val);
                            String? phone = Validator().name(val);
                            if (notEmpty != null) {
                              return notEmpty;
                            }
                            return phone;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        FormWithLabel(
                          controller: _bloc.handphoneController,
                          label: "Nomer Telepon",
                          labelText: "Masukan Nomer Telepon",
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            String? notEmpty = Validator().notEmpty(val);
                            String? phone = Validator().phone(val);
                            if (notEmpty != null) {
                              return notEmpty;
                            }
                            return phone;
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const TextInter(
                          text: "Group Pelanggan",
                          size: 14,
                          fontWeight: Weightenum.bold,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Theme(
                          data: ThemeData(
                            hintColor: _bloc.validationDropdownResult == null
                                ? null
                                : Colors.red[700],
                          ),
                          child: DropDownMultiSelect(
                            whenEmpty: "Pilih Group Pelanggan",
                            onChanged: (val) {
                              debugPrint("changed");
                              _bloc.setSelectedList();
                              _bloc.validateDropdown();
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
                                    size: 18,
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
                                  size: 18,
                                  fontWeight: Weightenum.regular,
                                  color: _bloc.selectedListGroup.contains(str)
                                      ? PaletteColor.textPrimary
                                      : PaletteColor.textSecondary1,
                                ),
                              );
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        _bloc.validationDropdownResult == null
                                            ? PaletteColor.borderEmphasis
                                            : Colors.red,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              hintStyle: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: PaletteColor.textSecondary2,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        _bloc.validationDropdownResult == null
                                            ? PaletteColor.primary
                                            : Colors.red,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              // contentPadding: EdgeInsets.zero,
                            ),
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
                        if (_bloc.validationDropdownResult != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 14, top: 8),
                            child: Text(
                              _bloc.validationDropdownResult ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[600],
                              ),
                              maxLines: 2,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: PaletteColor.white,
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 12, top: 12),
                    child: PrimaryButton(
                      enabled: _bloc.isCompleted(),
                      title: "Simpan",
                      forceAction: true,
                      onPressed: () {
                        _bloc.validateDropdown();
                        if (_formKey.currentState!.validate() &&
                            _bloc.validationDropdownResult == null) {
                          BlocProvider.of<KontakPelangganBloc>(context)
                              .addContact(_bloc.createContactObj(
                                  BlocProvider.of<KontakPelangganBloc>(context)
                                      .countList()));
                          RouteApp.popScreen(context);
                        }
                      },
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
