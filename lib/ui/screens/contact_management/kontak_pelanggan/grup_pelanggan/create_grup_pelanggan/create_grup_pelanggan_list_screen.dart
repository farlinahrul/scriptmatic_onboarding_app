import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/contact_tile_with_checkbox.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/custom_header_bottom_sheet.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/custom_search_delegate.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/empty_contact_widget.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/edit_konta_pelanggan/edit_kontak_pelanggan_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/grup_pelanggan/create_grup_pelanggan/create_grup_pelanggan_detail_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_bloc.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/kontak_pelanggan_state.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/sinkronisasi_kontak/sinkronisasi_kontak_screen.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/bottom_sheet_helper.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_app_bar.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_search.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/persistent_header.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/primary_button.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_search_delegate.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

import 'create_grup_pelanggan_bloc.dart';
import 'create_grup_pelanggan_state.dart';

class CreateGrupPelangganListScreen extends StatefulWidget {
  const CreateGrupPelangganListScreen({Key? key}) : super(key: key);

  @override
  State<CreateGrupPelangganListScreen> createState() =>
      _CreateGrupPelangganListScreenState();
}

class _CreateGrupPelangganListScreenState
    extends State<CreateGrupPelangganListScreen> {
  late CreateGrupPelangganBloc _bloc;

  // late GrupPelangganBloc _blocGrup;
  late KontakPelangganBloc _blocKontak;

  final double paddingValue = 24;

  @override
  void dispose() {
    super.dispose();
    _bloc.init();
  }

  @override
  void initState() {
    super.initState();
    _blocKontak = context.read<KontakPelangganBloc>();
    _bloc = context.read<CreateGrupPelangganBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: PaletteColor.white,
      appBar: const CustomAppBar(
        title: "Grup Baru",
      ),
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return customHeaderSliver(context, innerBoxIsScrolled);
            }),
            body: BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
              builder: (context, state) {
                List<KontakPelanggan> dataList = [];
                if (state is KontakPelangganLoaded) {
                  dataList = state.data;
                } else if (state is KontakPelangganLoadedWithFilterState) {
                  dataList = state.data;
                }

                if (dataList.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...constantBodyWidgets(context),
                        BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
                          builder: (context, state) {
                            if (state is KontakPelangganLoadedWithFilterState &&
                                state.data.isNotEmpty) {
                              return Center(
                                child: TextInter(
                                  text: "${state.data.length} KONTAK DITEMUKAN",
                                  size: 13,
                                  fontWeight: Weightenum.semiBold,
                                  color: PaletteColor.textGrey,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        BlocBuilder<CreateGrupPelangganBloc,
                            CreateGrupPelangganState>(
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: paddingValue),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  KontakPelanggan data = dataList[index];
                                  return ContactTileWithCheckbox(
                                    name: data.name,
                                    number: data.number,
                                    types: data.types,
                                    isSelected: _bloc.isDataTempExist(data),
                                    onChanged: ((val) {
                                      _bloc.addOrRemoveSelectedDataTemp(
                                          data, val ?? false);
                                    }),
                                    onTap: () {
                                      RouteApp.pushScreen(
                                          context,
                                          EditKontakPelangganScreen(
                                            data: data,
                                          ));
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
                        BlocBuilder<CreateGrupPelangganBloc,
                            CreateGrupPelangganState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: _bloc.selectedListKontakTemp.isEmpty
                                  ? 24
                                  : 96,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingValue),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...constantBodyWidgets(context),
                        const SizedBox(
                          height: 14,
                        ),
                        Expanded(
                            child: EmptyContactWidget(
                          textButton: "Sinkronisasikan Kontak",
                          onPressed: () {
                            RouteApp.pushScreen(
                                context, SinkronisasiKontakScreen());
                          },
                        )),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          BlocBuilder<CreateGrupPelangganBloc, CreateGrupPelangganState>(
            builder: (context, state) {
              if (_bloc.selectedListKontakTemp.isNotEmpty) {
                return Align(
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
                        _bloc.initDetail();
                        RouteApp.pushScreen(
                            context, CreateGrupPelangganDetailScreen());
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
    );
  }

  List<Widget> constantBodyWidgets(BuildContext context) {
    return [
      BlocBuilder<CreateGrupPelangganBloc, CreateGrupPelangganState>(
        builder: (context, state) {
          if (_bloc.selectedListKontakTemp.isEmpty) {
            return const SizedBox();
          }
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: MediaQuery.of(context).size.width,
            color: PaletteColor.grey20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingValue),
                  child: BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
                    builder: (context, state) {
                      return TextInter(
                        text:
                            "Terpilih ${_bloc.selectedListKontakTemp.length} dari ${_blocKontak.countList()} Kontak",
                        size: 16,
                        fontWeight: Weightenum.bold,
                        color: PaletteColor.primary,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: paddingValue),
                    itemCount: _bloc.selectedListKontakTemp.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _bloc.removeSelectedData(
                              _bloc.selectedListKontakTemp[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: PaletteColor.textGrey,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextInter(
                                text: _bloc.selectedListKontakTemp[index].name,
                                fontWeight: Weightenum.semiBold,
                                size: 14,
                                color: PaletteColor.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: PaletteColor.white,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: PaletteColor.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      const SizedBox(
        height: 12,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingValue),
        child: Wrap(
          children: [
            const TextInter(
              text: "Pilih Peserta Grup",
              size: 16,
              fontWeight: Weightenum.bold,
            ),
            BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
              builder: (context, state) {
                if (state is KontakPelangganLoaded) {
                  return TextInter(
                    text: " (${state.data.length} Kontak)",
                    size: 16,
                    fontWeight: Weightenum.medium,
                    color: PaletteColor.textGrey,
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
      const SizedBox(
        height: 14,
      ),
    ];
  }

  List<Widget> generateSelectedContactWidgets() {
    return _bloc.selectedListKontakTemp
        .map(
          (str) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: PaletteColor.textGrey,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInter(
                  text: str.name,
                  fontWeight: Weightenum.semiBold,
                  size: 14,
                  color: PaletteColor.primary20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(20),
                    color: PaletteColor.primary20,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 14,
                    color: PaletteColor.textGrey,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget buildFilterChips({
    required Function(bool, String) onChipSelected,
    required List<String> selectedGroupFilterTemp,
  }) =>
      Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 4,
          runSpacing: 0,
          children: _blocKontak.listgroup
              .map(
                (str) => ChoiceChip(
                  label: TextInter(
                    text: str.toUpperCase(),
                    fontWeight: Weightenum.semiBold,
                    size: 12,
                    color: selectedGroupFilterTemp.contains(str)
                        ? PaletteColor.primary20
                        : PaletteColor.primary,
                  ),
                  onSelected: (val) {
                    // setState(() {
                    //   _bloc.setSelectedGroupFilter(val, str);
                    // });
                    onChipSelected(val, str);
                  },
                  selectedColor: PaletteColor.primary,
                  backgroundColor: PaletteColor.primary20,
                  selected: selectedGroupFilterTemp.contains(str),
                ),
              )
              .toList(),
        ),
      );

  Widget buildSortChips({
    required Function(bool, String) onChipSelected,
    required String? selectedSort,
  }) =>
      Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 4,
          runSpacing: 0,
          children: _blocKontak.listSort
              .map(
                (str) => ChoiceChip(
                  label: TextInter(
                    text: str.toUpperCase(),
                    fontWeight: Weightenum.semiBold,
                    size: 12,
                    color: selectedSort == str
                        ? PaletteColor.primary20
                        : PaletteColor.primary,
                  ),
                  onSelected: (val) {
                    // setState(() {
                    //   _bloc.setSelectedGroupFilter(val, str);
                    // });
                    onChipSelected(val, str);
                  },
                  selectedColor: PaletteColor.primary,
                  backgroundColor: PaletteColor.primary20,
                  selected: selectedSort == str,
                ),
              )
              .toList(),
        ),
      );

  Widget _filterWidget({int selectedCount = 0}) {
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
              size: 13,
            ),
            const SizedBox(
              width: 6,
            ),
            if (selectedCount != 0)
              CircleAvatar(
                radius: 10,
                child: TextInter(
                  text: selectedCount.toString(),
                  fontWeight: Weightenum.regular,
                  size: 12,
                  color: Colors.white,
                ),
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
              size: 13,
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

  List<Widget> customHeaderSliver(BuildContext ctx, bool innerBoxIsScroller) {
    return [
      SliverPersistentHeader(
        pinned: false,
        delegate: PersistentHeader(
          height: 20,
        ),
      ),
      SliverPersistentHeader(
        pinned: false,
        floating: true,
        delegate: PersistentHeader(
          height: 48,
          widget: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingValue,
            ),
            child: BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
              builder: (context, state) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          String? query =
                              await showSearchFromCustomDelegate<String>(
                            context: context,
                            delegate: CustomSearchDelegate(
                              contextPage: context,
                              controller: _blocKontak.searchController,
                              initQuery: _blocKontak.searchController.text,
                              suggestions: [
                                "Brad Simmons",
                                "Brad",
                                "Simmons",
                              ],
                            ),
                          );
                          if (query != null) {
                            _blocKontak.searchController.text = query;
                            _blocKontak.sortFilterAndSearch();
                          }
                        },
                        child: FormSearch(
                          enabled: false,
                          controller: _blocKontak.searchController,
                          maxLines: 1,
                          // enableBorder: false,
                          iconPrefix: IconButton(
                            icon: SvgPicture.asset(
                              AppIconsPaths.search,
                              width: 20,
                              height: 20,
                              fit: BoxFit.fitWidth,
                              color: PaletteColor.black,
                            ),
                            onPressed: () {},
                          ),
                          labelText: "Cari Kontak",
                          onTap: () {},
                          onSaved: (value) {
                            _blocKontak.sortFilterAndSearch();
                          },
                          onFieldSubmitted: (value) {
                            _blocKontak.sortFilterAndSearch();
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
                      builder: (context, state) {
                        if (_blocKontak.searchController.text.isNotEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(left: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: PaletteColor.textGrey),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: PaletteColor.bgSecondary,
                              child: IconButton(
                                onPressed: () {
                                  _blocKontak.searchController.text = "";
                                  _blocKontak.sortFilterAndSearch();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: PaletteColor.textGrey,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                );
              },
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
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
                    builder: (context, state) {
                      return _sortWidget();
                    },
                  ),
                  onTap: () {
                    showBarBottomSheet(
                      ctx,
                      builder: (ctx) {
                        String? selectedSortTemp = _blocKontak.selectedSort;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 32,
                                right: 32,
                                top: 32,
                                bottom: 34,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomHeaderBottomSheet(
                                    title: "Sort",
                                    onClear: () {
                                      setState(() {
                                        selectedSortTemp = null;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  buildSortChips(
                                    selectedSort: selectedSortTemp,
                                    onChipSelected: (isSelected, str) {
                                      setState(() {
                                        if (isSelected) {
                                          selectedSortTemp = str;
                                        } else {
                                          selectedSortTemp = null;
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  PrimaryButton(
                                    onPressed: () {
                                      _blocKontak.selectedSort =
                                          selectedSortTemp;
                                      _blocKontak.sortFilterAndSearch();
                                      RouteApp.popScreen(context);
                                    },
                                    title:
                                        "Apply ${selectedSortTemp != null ? '(1)' : ""}",
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                GestureDetector(
                  child: BlocBuilder<KontakPelangganBloc, KontakPelangganState>(
                    builder: (context, state) {
                      return _filterWidget(
                          selectedCount:
                              _blocKontak.selectedGroupFilter.length);
                    },
                  ),
                  // onTap: () {
                  //   showBarBottomSheet(
                  //     ctx,
                  //     builder: (ctx) {
                  //       List<String> selectedGroupFilterTemp =
                  //           _blocKontak.selectedGroupFilter.toList();
                  //       return StatefulBuilder(
                  //         builder: ((context, setState) {
                  //           return Padding(
                  //             padding: const EdgeInsets.only(
                  //               left: 32,
                  //               right: 32,
                  //               top: 32,
                  //               bottom: 34,
                  //             ),
                  //             child: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 CustomHeaderBottomSheet(
                  //                   onClear: () {
                  //                     setState(() {
                  //                       selectedGroupFilterTemp = [];
                  //                     });
                  //                   },
                  //                   title: "Filter",
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 16,
                  //                 ),
                  //                 buildFilterChips(
                  //                   selectedGroupFilterTemp:
                  //                       selectedGroupFilterTemp,
                  //                   onChipSelected: (isSelected, str) {
                  //                     setState(() {
                  //                       if (isSelected) {
                  //                         selectedGroupFilterTemp.add(str);
                  //                       } else {
                  //                         selectedGroupFilterTemp.remove(str);
                  //                       }
                  //                     });
                  //                   },
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 32,
                  //                 ),
                  //                 PrimaryButton(
                  //                   onPressed: () {
                  //                     _blocKontak.selectedGroupFilter =
                  //                         selectedGroupFilterTemp;
                  //                     _blocKontak.sortFilterAndSearch();
                  //                     RouteApp.popScreen(context);
                  //                   },
                  //                   title:
                  //                       "Apply ${selectedGroupFilterTemp.isNotEmpty ? '(' + selectedGroupFilterTemp.length.toString() + ')' : ""}",
                  //                 )
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //       );
                  //     },
                  //   );
                  // },
                ),
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
  }
}
