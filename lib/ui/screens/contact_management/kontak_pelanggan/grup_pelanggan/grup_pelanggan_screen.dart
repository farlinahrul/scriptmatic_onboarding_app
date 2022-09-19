import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/custom_header_bottom_sheet.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/custom_search_delegate.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/components/empty_contact_widget.dart';
import 'package:scriptmatic_onboarding_app/ui/screens/contact_management/kontak_pelanggan/grup_pelanggan/grup_pelanggan_state.dart';
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

import '../components/grup_tile.dart';
import '../components/kontak_pelanggan_action_tile.dart';
import 'create_grup_pelanggan/create_grup_pelanggan_list_screen.dart';
import 'edit_grup_pelanggan/edit_grup_pelanggan_screen.dart';
import 'grup_pelanggan_bloc.dart';

class GrupPelangganScreen extends StatelessWidget {
  GrupPelangganScreen({Key? key}) : super(key: key);

  late GrupPelangganBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = context.read<GrupPelangganBloc>()..init();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: PaletteColor.white,
      appBar: const CustomAppBar(
        title: "Grup Pelanggan",
      ),
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return customHeaderSliver(context, innerBoxIsScrolled);
        }),
        body: BlocBuilder<GrupPelangganBloc, GrupPelangganState>(
          builder: (context, state) {
            List<GrupPelanggan> dataList = [];
            if (state is GrupPelangganLoaded) {
              dataList = state.data;
            } else if (state is GrupPelangganLoadedWithFilterState) {
              dataList = state.data;
            }

            if (dataList.isNotEmpty) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...constantBodyWidgets(context),
                      BlocBuilder<GrupPelangganBloc, GrupPelangganState>(
                        builder: (context, state) {
                          if (state is GrupPelangganLoadedWithFilterState &&
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
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          GrupPelanggan data = dataList[index];
                          return GrupTile(
                            name: data.name,
                            countContacts: data.contacts.length,
                            color: data.color,
                            onTap: () {
                              RouteApp.pushScreen(
                                  context,
                                  EditGrupPelangganScreen(
                                    data: data,
                                  ));
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...constantBodyWidgets(context),
                    const SizedBox(
                      height: 14,
                    ),
                    Expanded(
                        child: EmptyContactWidget(
                      textButton: "Tambahkan Grup",
                      onPressed: () {
                        RouteApp.pushScreen(
                            context, CreateGrupPelangganListScreen());
                      },
                    )),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> constantBodyWidgets(BuildContext context) {
    return [
      const SizedBox(
        height: 8,
      ),
      InkWell(
        onTap: () {
          RouteApp.pushScreen(context, CreateGrupPelangganListScreen());
        },
        child: Ink(
          child: const KontakPelangganActionTile(
            text: "Buat Grup Baru",
            svgPath: AppIconsPaths.addUser,
          ),
        ),
      ),
      const Divider(
        thickness: 1,
      ),
      const SizedBox(
        height: 12,
      ),
      Wrap(
        children: [
          const TextInter(
            text: "Daftar Grup Pelanggan",
            size: 16,
            fontWeight: Weightenum.bold,
          ),
          BlocBuilder<GrupPelangganBloc, GrupPelangganState>(
            builder: (context, state) {
              if (state is GrupPelangganLoaded) {
                return TextInter(
                  text: " (${state.data.length} Grup)",
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
      const SizedBox(
        height: 14,
      ),
    ];
  }

  // Widget buildFilterChips({
  //   required Function(bool, String) onChipSelected,
  //   required List<String> selectedGroupFilterTemp,
  // }) =>
  //     Align(
  //       alignment: Alignment.topLeft,
  //       child: Wrap(
  //         spacing: 4,
  //         runSpacing: 0,
  //         children: _bloc.listgroup
  //             .map(
  //               (str) => ChoiceChip(
  //                 label: TextInter(
  //                   text: str.toUpperCase(),
  //                   fontWeight: Weightenum.semiBold,
  //                   size: 12,
  //                   color: selectedGroupFilterTemp.contains(str)
  //                       ? PaletteColor.primary20
  //                       : PaletteColor.primary,
  //                 ),
  //                 onSelected: (val) {
  //                   // setState(() {
  //                   //   _bloc.setSelectedGroupFilter(val, str);
  //                   // });
  //                   onChipSelected(val, str);
  //                 },
  //                 selectedColor: PaletteColor.primary,
  //                 backgroundColor: PaletteColor.primary20,
  //                 selected: selectedGroupFilterTemp.contains(str),
  //               ),
  //             )
  //             .toList(),
  //       ),
  //     );

  Widget buildSortChips({
    required Function(bool, String) onChipSelected,
    required String? selectedSort,
  }) =>
      Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 4,
          runSpacing: 0,
          children: _bloc.listSort
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: BlocBuilder<GrupPelangganBloc, GrupPelangganState>(
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
                                controller: _bloc.searchController,
                                initQuery: _bloc.searchController.text,
                                suggestions: [
                                  "Loyal Customer",
                                  "Returning Customer",
                                  "New",
                                  "Tokopedia",
                                ]),
                          );
                          if (query != null) {
                            _bloc.searchController.text = query;
                            _bloc.sortFilterAndSearch();
                          }
                        },
                        child: FormSearch(
                          enabled: false,
                          controller: _bloc.searchController,
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
                          labelText: "Cari Grup",
                          onTap: () {},
                          onSaved: (value) {
                            _bloc.sortFilterAndSearch();
                          },
                          onFieldSubmitted: (value) {
                            _bloc.sortFilterAndSearch();
                          },
                        ),
                      ),
                    ),
                    BlocBuilder<GrupPelangganBloc, GrupPelangganState>(
                      builder: (context, state) {
                        if (_bloc.searchController.text.isNotEmpty) {
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
                                  _bloc.searchController.text = "";
                                  _bloc.sortFilterAndSearch();
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
                  child: BlocBuilder<GrupPelangganBloc, GrupPelangganState>(
                    builder: (context, state) {
                      return _sortWidget();
                    },
                  ),
                  onTap: () {
                    showBarBottomSheet(
                      ctx,
                      builder: (ctx) {
                        String? selectedSortTemp = _bloc.selectedSort;
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
                                      _bloc.selectedSort = selectedSortTemp;
                                      _bloc.sortFilterAndSearch();
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
                  child: BlocBuilder<GrupPelangganBloc, GrupPelangganState>(
                    builder: (context, state) {
                      return _filterWidget(
                          selectedCount: _bloc.selectedGroupFilter.length);
                    },
                  ),
                  // onTap: () {
                  //   showBarBottomSheet(
                  //     ctx,
                  //     builder: (ctx) {
                  //       List<String> selectedGroupFilterTemp =
                  //           _bloc.selectedGroupFilter.toList();
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
                  //                 // buildFilterChips(
                  //                 //   selectedGroupFilterTemp:
                  //                 //       selectedGroupFilterTemp,
                  //                 //   onChipSelected: (isSelected, str) {
                  //                 //     setState(() {
                  //                 //       if (isSelected) {
                  //                 //         selectedGroupFilterTemp.add(str);
                  //                 //       } else {
                  //                 //         selectedGroupFilterTemp.remove(str);
                  //                 //       }
                  //                 //     });
                  //                 //   },
                  //                 // ),
                  //                 const SizedBox(
                  //                   height: 32,
                  //                 ),
                  //                 PrimaryButton(
                  //                   onPressed: () {
                  //                     _bloc.selectedGroupFilter =
                  //                         selectedGroupFilterTemp;
                  //                     _bloc.sortFilterAndSearch();
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
