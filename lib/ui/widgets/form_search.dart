import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class FormSearch extends StatelessWidget {
  const FormSearch({
    Key? key,
    this.focusNode,
    this.controller,
    this.iconPrefix,
    required this.labelText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.enableBorder = true,
    this.autofocus = false,
    this.minLines = 1,
    this.maxLines,
    required this.onTap,
    this.onChanged,
    required this.onSaved,
    this.backgroundColor,
    this.iconSuffix,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputAction,
  }) : super(key: key);

  final TextEditingController? controller;
  final Widget? iconPrefix;
  final Widget? iconSuffix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final bool obscureText;
  final bool enabled;
  final bool enableBorder;
  final bool autofocus;
  final int minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final void Function() onTap;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      decoration: InputDecoration(
        border: enableBorder
            ? OutlineInputBorder(
                borderSide:
                    const BorderSide(color: PaletteColor.borderEmphasis),
                borderRadius: BorderRadius.circular(50),
                gapPadding: 0,
              )
            : null,
        filled: true,
        fillColor: backgroundColor ?? PaletteColor.bgSecondary,
        prefixIcon: iconPrefix,
        suffixIcon: iconSuffix,
        hintText: labelText,
        hintStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: PaletteColor.textSecondary2,
        ),
        focusedBorder: enableBorder
            ? OutlineInputBorder(
                borderSide:
                    const BorderSide(color: PaletteColor.primary, width: 1.0),
                borderRadius: BorderRadius.circular(50),
                gapPadding: 0,
              )
            : null,
        contentPadding: const EdgeInsets.all(0),
      ),
      onTap: () {
        onTap();
      },
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: PaletteColor.textPrimary,
      ),
      textInputAction: inputAction,
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
