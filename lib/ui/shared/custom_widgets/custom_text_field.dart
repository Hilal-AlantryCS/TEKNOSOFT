import 'package:flutter/material.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String label;
  final int? maxLines;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLines,
    this.hintStyle,
    this.style,
    this.validator,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.top,
      style: style ?? TextStyle(color: AppColors.greyColor),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(screenWidth(20)),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        label: CustomText(
          label,
          type: TextStyleType.BODY,
        ),
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              color: AppColors.greyColor,
              fontSize: screenWidth(20),
            ),
      ),
    );
  }
}
