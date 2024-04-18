import 'package:flutter/material.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';

class CustomListTileButton extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final void Function() onTap;
  const CustomListTileButton({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: ListTile(
        title: CustomText(
          title,
          type: TextStyleType.SUBTITLE,
          textColor: AppColors.blueColor,
        ),
        subtitle: CustomText(
          subTitle,
          type: TextStyleType.SMALL,
        ),
        leading: Icon(
          icon,
          color: AppColors.blueColor,
        ),
      ),
    );
  }
}
