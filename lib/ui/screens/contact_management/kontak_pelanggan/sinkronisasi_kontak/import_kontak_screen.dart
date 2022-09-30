import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/contact_tile_with_checkbox.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/show_dialog.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

import '../../../../../data/blocs/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import '../../../../../data/blocs/contact_management/kontak_pelanggan/sinkronisasi_kontak/sinkronisasi_kontak_bloc.dart';
import '../../../../../data/blocs/contact_management/kontak_pelanggan/sinkronisasi_kontak/sinkronisasi_kontak_state.dart';
import '../../../../../models/kontak_pelanggan.dart';

class ImportKontakScreen extends StatefulWidget {
  const ImportKontakScreen({Key? key}) : super(key: key);

  @override
  State<ImportKontakScreen> createState() => _ImportKontakScreenState();
}

class _ImportKontakScreenState extends State<ImportKontakScreen> {
  late SinkronisasiKontakBloc _bloc;

  late KontakPelangganBloc _blocKontak;

  final double paddingValue = 24;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SinkronisasiKontakBloc>();
    _blocKontak = context.read<KontakPelangganBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return ShowDialog(
              title: "Belum Disimpan",
              description:
                  "Perubahan belum disimpan, apakah anda yakin keluar dari halaman ini?",
              negativeTitle: "Tidak",
              positiveTitle: "Ya, Yakin",
              negativeAction: () => Navigator.of(context).pop(false),
              positiveAction: () => Navigator.of(context).pop(true),
            );
          },
        ) ??
        false;
  }

  void onBackPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return ShowDialog(
          title: "Belum Disimpan",
          description:
              "Perubahan belum disimpan, apakah anda yakin keluar dari halaman ini?",
          negativeTitle: "Tidak",
          positiveTitle: "Ya, Yakin",
          negativeAction: () {
            RouteApp.popScreen(context);
          },
          positiveAction: () {
            RouteApp.popScreen(context);
            RouteApp.popScreen(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Import Kontak",
          onPressed: () {
            if (_bloc.listData.isNotEmpty) {
              onBackPressed();
            } else {
              RouteApp.popScreen(context);
            }
          },
        ),
        backgroundColor: PaletteColor.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingValue),
                  child: const TextInter(
                    text: "Import Kontak Pelanggan",
                    size: 16,
                    fontWeight: Weightenum.semiBold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingValue),
                  child: const TextInter(
                    text: "Tambahkan kontak pelanggan secara otomatis.",
                    size: 14,
                    fontWeight: Weightenum.regular,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      _bloc.listDataTemp.isNotEmpty
                          ? Center(
                              child: TextInter(
                                text:
                                    "${_bloc.listDataTemp.length} KONTAK DITEMUKAN",
                                size: 13,
                                fontWeight: Weightenum.semiBold,
                                color: PaletteColor.textGrey,
                              ),
                            )
                          : const SizedBox(),
                      _bloc.listDataTemp.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: paddingValue),
                                itemBuilder: (context, index) {
                                  KontakPelanggan contact =
                                      _bloc.listDataTemp[index];
                                  return ContactTileWithCheckbox(
                                    name: contact.name,
                                    number: contact.number,
                                    onChanged: (isSelected) {
                                      _bloc.changeStatusItem(
                                          contact, isSelected);
                                    },
                                    onTap: () {},
                                    isSelected: _bloc.isSelected(contact),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: _bloc.listDataTemp.length,
                              ),
                            )
                          : const Expanded(
                              child: Center(
                                child: TextInter(
                                  fontWeight: Weightenum.bold,
                                  size: 14,
                                  text: "TIDAK DITEMUKAN KONTAK BARU",
                                  color: PaletteColor.textGrey,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<SinkronisasiKontakBloc, SinkronisasiKontakState>(
              builder: (context, state) {
                if (_bloc.listData.isNotEmpty || _bloc.listDataTemp.isEmpty) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 72,
                      color: PaletteColor.white,
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 12, top: 12),
                      child: PrimaryButton(
                        title: _bloc.listDataTemp.isNotEmpty
                            ? "Selanjutnya"
                            : "Kembali",
                        forceAction: true,
                        onPressed: () {
                          if (_bloc.listDataTemp.isNotEmpty) {
                            _bloc.addAllData(
                                (val) => _blocKontak.addContact(val));
                          }
                          RouteApp.popScreen(context);
                          RouteApp.popScreen(context);
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
