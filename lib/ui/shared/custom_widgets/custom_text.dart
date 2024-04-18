import 'package:flutter/material.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyleType? type;

  final Color? textColor;
  final double? textSize;
  final FontWeight? textWeight;
  final TextAlign? textAlign;

  const CustomText(
    this.text, {
    super.key,
    this.type = TextStyleType.BODY,
    this.textColor,
    this.textSize,
    this.textWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: getStyle(),
    );
  }

  TextStyle? getStyle() {
    switch (type) {
      case TextStyleType.TITLE:
        return TextStyle(
          fontSize: textSize ?? (screenWidth(21.6)),
          fontWeight: textWeight ?? FontWeight.bold,
          color: textColor,
        );
      case TextStyleType.SUBTITLE:
        return TextStyle(
          fontSize: textSize ?? (screenWidth(22)),
          fontWeight: textWeight ?? FontWeight.bold,
          color: textColor,
        );
      case TextStyleType.BODY:
        return TextStyle(
          fontSize: textSize ?? (screenWidth(24)),
          fontWeight: textWeight ?? FontWeight.normal,
          color: textColor,
        );
      case TextStyleType.SMALL:
        return TextStyle(
          fontSize: textSize ?? (screenWidth(30)),
          fontWeight: textWeight ?? FontWeight.normal,
          color: textColor,
        );
      case TextStyleType.CUSTOM:
        return TextStyle(
          fontSize: textSize,
          fontWeight: textWeight,
          color: textColor,
        );
      default:
        return TextStyle(
          fontSize: textSize ?? (screenWidth(24)),
          fontWeight: textWeight ?? FontWeight.normal,
          color: textColor,
        );
    }
  }
}
