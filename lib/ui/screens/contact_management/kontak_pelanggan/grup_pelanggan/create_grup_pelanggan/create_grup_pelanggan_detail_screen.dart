import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/contact_tile_with_checkbox.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/grup_pelanggan/grup_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_with_label_widget.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';
import 'package:scriptmatic_onboarding_app/utils/validator.dart';

import 'create_grup_pelanggan_bloc.dart';
import 'create_grup_pelanggan_state.dart';

class CreateGrupPelangganDetailScreen extends StatelessWidget {
  CreateGrupPelangganDetailScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late CreateGrupPelangganBloc _bloc;
  late GrupPelangganBloc _blocGrup;

  EdgeInsets paddingValue = const EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(BuildContext context) {
    _bloc = context.read<CreateGrupPelangganBloc>();
    _blocGrup = context.read<GrupPelangganBloc>();
    return Scaffold(
      backgroundColor: PaletteColor.white,
      appBar: const CustomAppBar(title: "Grup Baru"),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: paddingValue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormWithLabel(
                        controller: _bloc.groupNameController,
                        label: "Nama Grup",
                        labelText: "Masukan Nama Grup",
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          String? notEmpty = Validator().notEmpty(val);
                          String? name = Validator().name(val);
                          if (notEmpty != null) {
                            return notEmpty;
                          }
                          return name;
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      BlocBuilder<CreateGrupPelangganBloc,
                          CreateGrupPelangganState>(
                        builder: (context, state) {
                          return FormWithLabel(
                            controller: _bloc.hexColorController,
                            label: "Warna Tag",
                            labelText: "Pilih Warna Tag",
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              String? notEmpty = Validator().notEmpty(val);
                              String? hex = Validator().hexColor(val);
                              if (notEmpty != null) {
                                return notEmpty;
                              }
                              return hex;
                            },
                            onChanged: (val) {
                              if (Validator().hexColor(val) == null) {
                                debugPrint("Change");
                                _bloc.changeColorFromText();
                              }
                              _formKey.currentState!.validate();
                            },
                            iconSuffix: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: PaletteColor.textGrey)),
                              ),
                              child: GestureDetector(
                                onTap: () => {
                                  // raise the [showDialog] widget
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Pilih Warna'),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            enableAlpha: false,
                                            pickerColor: _bloc.selectedColor ??
                                                Colors.white,
                                            onColorChanged:
                                                _bloc.changeTempColor,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          PrimaryButton(
                                            marginHorizontal: 32,
                                            title: "Pilih",
                                            onPressed: () {
                                              _bloc.changeColor();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: PaletteColor.textGrey,
                                        width: 1.3),
                                    borderRadius: BorderRadius.circular(5),
                                    color: _bloc.selectedColor ?? Colors.white,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Wrap(
                        children: [
                          const TextInter(
                            text: "Peserta",
                            size: 16,
                            fontWeight: Weightenum.bold,
                          ),
                          BlocBuilder<CreateGrupPelangganBloc,
                              CreateGrupPelangganState>(
                            builder: (context, state) {
                              return TextInter(
                                text:
                                    " (${_bloc.selectedListKontak.length} Anggota)",
                                size: 16,
                                color: PaletteColor.textGrey,
                                fontWeight: Weightenum.medium,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CreateGrupPelangganBloc, CreateGrupPelangganState>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.separated(
                        padding: paddingValue,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: _bloc.selectedListKontakTemp.length,
                        itemBuilder: (context, index) {
                          KontakPelanggan data =
                              _bloc.selectedListKontakTemp[index];
                          return ContactTileWithCheckbox(
                            name: data.name,
                            number: data.number,
                            types: data.types,
                            isSelected: _bloc.isDataExist(data),
                            onChanged: ((val) {
                              _bloc.addOrRemoveSelectedData(data, val ?? false);
                            }),
                            onTap: () {
                              // RouteApp.pushScreen(
                              //     context,
                              //     EditKontakPelangganScreen(
                              //       data: data,
                              //     ));
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                    );
                  },
                ),
                BlocBuilder<CreateGrupPelangganBloc, CreateGrupPelangganState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: _bloc.selectedListKontakTemp.isEmpty ? 24 : 96,
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 72,
                color: PaletteColor.white,
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 12, top: 12),
                child: PrimaryButton(
                  title: "Selanjutnya",
                  forceAction: true,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _blocGrup.addData(_bloc.createObj());
                      RouteApp.popScreen(context);
                      RouteApp.popScreen(context);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
