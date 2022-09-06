import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final Gradient? gradient;
  final double width;
  final double? height;
  final void Function()? onPressed;
  final double? borderRadius;
  final bool enabled;
  final bool shadowed;
  final double marginHorizontal;
  final String? title;
  final bool reverse;
  final bool forceAction;

  const PrimaryButton({
    Key? key,
    this.title,
    this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.borderRadius,
    this.enabled = true,
    this.shadowed = true,
    this.reverse = false,
    this.marginHorizontal = 0,
    this.forceAction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
              colors: enabled
                  ? <Color>[PaletteColor.primary, PaletteColor.primary]
                  : <Color>[Colors.transparent, Colors.transparent],
            ),
        boxShadow: [
          enabled && shadowed
              ? const BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.5),
                  blurRadius: 1.5,
                )
              : const BoxShadow(color: Colors.transparent),
        ],
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        border: !enabled
            ? Border.all(
                color: PaletteColor.borderEmphasis,
                width: 2,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          onTap: enabled || forceAction ? onPressed ?? () {} : null,
          child: Center(
            child: child ??
                TextInter(
                  size: 16,
                  color: enabled
                      ? PaletteColor.textPrimaryInverted
                      : PaletteColor.textGrey,
                  fontWeight: Weightenum.semiBold,
                  text: title.toString(),
                ),
          ),
        ),
      ),
    );
  }
}
