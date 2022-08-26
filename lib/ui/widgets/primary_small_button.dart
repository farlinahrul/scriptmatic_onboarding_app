import 'package:flutter/material.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';
import 'package:scriptmatic_onboarding_app/utils/palette_color.dart';

class PrimarySmallButton extends StatelessWidget {
  final Widget? child;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final double? borderRadius;
  final bool enabled;
  final bool shadowed;
  final double marginHorizontal;
  final double marginVertical;
  final String? title;
  final bool reverse;

  const PrimarySmallButton({
    Key? key,
    this.title,
    this.child,
    this.gradient,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    this.enabled = true,
    this.shadowed = true,
    this.reverse = false,
    this.marginHorizontal = 20,
    this.marginVertical = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginVertical),
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
              colors: enabled
                  ? <Color>[PaletteColor.primary, PaletteColor.primary]
                  : <Color>[PaletteColor.grey, PaletteColor.grey],
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
        borderRadius: BorderRadius.circular(borderRadius ?? 6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
          onTap: enabled ? onPressed ?? () {} : null,
          child: TextInter(
            size: 16,
            color: PaletteColor.textPrimaryInverted,
            fontWeight: Weightenum.semiBold,
            text: title.toString(),
          ),
        ),
      ),
    );
  }
}
