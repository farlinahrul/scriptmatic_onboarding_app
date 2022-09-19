import 'package:flutter/widgets.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/form_input_field_with_icon.dart';
import 'package:scriptmatic_onboarding_app/ui/widgets/text/text_inter.dart';
import 'package:scriptmatic_onboarding_app/utils/constants.dart';

class FormWithLabel extends StatelessWidget {
  const FormWithLabel({
    Key? key,
    required this.label,
    required this.labelText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.iconSuffix,
  }) : super(key: key);

  final String label;
  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Widget? iconSuffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInter(
          text: label,
          size: 14,
          fontWeight: Weightenum.bold,
        ),
        const SizedBox(
          height: 12,
        ),
        FormInputFieldWithIcon(
          borderRadius: 14,
          controller: controller,
          iconSuffix: iconSuffix,
          labelText: labelText,
          onChanged: onChanged,
          onSaved: (val) {},
          onTap: () {},
          validator: validator,
        ),
      ],
    );
  }
}
