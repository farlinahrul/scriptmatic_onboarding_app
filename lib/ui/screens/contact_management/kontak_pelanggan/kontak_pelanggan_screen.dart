import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/contact_tile.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_search.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/persistent_header.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_small_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class KontakPelangganScreen extends StatelessWidget {
  KontakPelangganScreen({Key? key}) : super(key: key);

  final KontakPelangganBloc _bloc = KontakPelangganBloc()..init();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Kontak Pelanggan",
        ),
        body: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return [
              // SliverAppBar(
              //   pinned: false,
              //   title: Text(
              //     "Kontak Pelanggan",
              //     style: GoogleFonts.inter(
              //       color: PaletteColor.textPrimary,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 18,
              //     ),
              //   ),
              //   leading: IconButton(
              //     icon: SvgPicture.asset(
              //       AppIconsPaths.leftButton,
              //       width: 22,
              //       height: 22,
              //       color: PaletteColor.primary,
              //     ),
              //     onPressed: () {
              //       RouteApp.popScreen(context);
              //     },
              //   ),
              //   elevation: 0,
              //   centerTitle: true,
              //   backgroundColor: Colors.white,
              // ),
              SliverPersistentHeader(
                pinned: false,
                delegate: PersistentHeader(
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: FormSearch(
                      maxLines: 1,
                      // enableBorder: false,
                      iconPrefix: IconButton(
                        icon: SvgPicture.asset(
                          AppIconsPaths.search,
                          width: 20,
                          height: 20,
                          fit: BoxFit.fitWidth,
                        ),
                        onPressed: () {},
                      ),
                      labelText: "Cari Kontak",
                      onTap: () {},
                      onSaved: (value) {},
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  height: 10,
                ),
              ),
              SliverPersistentHeader(
                pinned: false,
                delegate: PersistentHeader(
                  height: 10,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _sortWidget(),
                        _filterWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  height: 5,
                ),
              ),
              SliverPersistentHeader(
                pinned: false,
                delegate: PersistentHeader(
                  height: 5,
                ),
              ),
            ];
          }),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _UserActionTile(
                            text: "Tambahkan Kontak",
                            svgPath: AppIconsPaths.addUser,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const _UserActionTile(
                            text: "Sinkronisasikan Kontak",
                            svgPath: AppIconsPaths.syncUser,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const TextInter(
                            text: "Daftar Kontak Pelanggan",
                            size: 14,
                            fontWeight: Weightenum.bold,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          BlocBuilder<KontakPelangganBloc,
                              KontakPelangganState>(
                            builder: (context, state) {
                              if (state is KontakPelangganLoaded) {
                                if (state.data.isNotEmpty) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: state.data.length,
                                    itemBuilder: (context, index) {
                                      KontakPelanggan data = state.data[index];
                                      return ContactTile(
                                        name: data.name,
                                        number: data.number,
                                        type: data.type.value,
                                        color: data.type.color,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImagePaths.emptyList,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        const TextInter(
                                          text: "Kontak Kosong",
                                          size: 16,
                                          fontWeight: Weightenum.bold,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const TextInter(
                                          text:
                                              "Silahkan tambahkan kontak terlebih dahulu",
                                          size: 14,
                                          fontWeight: Weightenum.regular,
                                          color: PaletteColor.black80,
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        const Flexible(
                                          child: PrimarySmallButton(
                                            title: "Sinkronisasikan Kontak",
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              }
                              return const Center(
                                child: Text("Kosong"),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: PaletteColor.grey80,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIconsPaths.filter,
              width: 14,
              color: PaletteColor.black,
            ),
            const SizedBox(
              width: 3,
            ),
            const TextInter(
              text: "Filter",
              fontWeight: Weightenum.regular,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: PaletteColor.grey80,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIconsPaths.sort,
              width: 14,
              color: PaletteColor.black,
            ),
            const SizedBox(
              width: 3,
            ),
            const TextInter(
              text: "Sort",
              fontWeight: Weightenum.regular,
              size: 12,
            ),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              AppIconsPaths.arrowDown,
              color: PaletteColor.textPrimary,
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _UserActionTile extends StatelessWidget {
  const _UserActionTile({
    Key? key,
    required this.text,
    required this.svgPath,
  }) : super(key: key);

  final String text;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: PaletteColor.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              svgPath,
              width: 22,
              height: 22,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        TextInter(
          text: text,
          size: 14,
          fontWeight: Weightenum.regular,
        )
      ],
    );
  }
}
