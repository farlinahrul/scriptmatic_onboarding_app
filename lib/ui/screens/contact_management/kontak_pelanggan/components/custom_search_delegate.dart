import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/custom_search_delegate.dart'
    as custom;
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class CustomSearchDelegate extends custom.SearchDelegate<String> {
  CustomSearchDelegate(
      {required this.contextPage, this.controller, String? initQuery});

  BuildContext contextPage;
  TextEditingController? controller;
  List<String> suggestions = [
    "Farli",
    "Nahrul",
    "Javier",
    "Alpha",
    "Beta",
    "Testing",
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: PaletteColor.textSecondary2,
            ),
            border: InputBorder.none,
            labelStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: PaletteColor.textPrimary,
            ),
          ),
    );
  }

  @override
  String get searchFieldLabel => "Cari Kontak";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        AppIconsPaths.search,
        width: 20,
        height: 20,
        fit: BoxFit.fitWidth,
        color: PaletteColor.black,
      ),
      onPressed: () {
        close(context, "null");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // unused
    return const SizedBox();
  }

  @override
  void showResults(BuildContext context) {
    close(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionsTemp = query.isEmpty
        ? suggestions
        : suggestions
            .where((element) =>
                element.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return StatefulBuilder(
      builder: ((context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextInter(
                text: "RECENT SEARCHES",
                size: 12,
                fontWeight: Weightenum.bold,
                color: PaletteColor.textGrey,
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: suggestionsTemp.length,
                  itemBuilder: (content, index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      query = suggestionsTemp[index];
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextInter(
                            text: suggestionsTemp[index],
                            size: 16,
                            fontWeight: Weightenum.regular,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                suggestions.remove(suggestionsTemp[index]);
                                suggestionsTemp.remove(suggestionsTemp[index]);
                              });
                            },
                            child: SvgPicture.asset(
                              AppIconsPaths.exit,
                              width: 14,
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
