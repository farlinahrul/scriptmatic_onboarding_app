import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriptmatic_onboarding_app/utils/extensions.dart';
import 'package:scriptmatic_onboarding_app/utils/images.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onPressed,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;
  final String title;
  final void Function()? onPressed;
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: GoogleFonts.inter(
          color: PaletteColor.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          AppIconsPaths.leftButton,
          width: 22,
          height: 22,
          color: PaletteColor.primary,
        ),
        onPressed: widget.onPressed ??
            () {
              RouteApp.popScreen(context);
            },
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
