import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/display_tasks_by_category_view/display_tasks_by_category_view.dart';

class CustomCategoryDetails extends StatelessWidget {
  final Category category;
  final String title;
  final IconData icon;
  final List<Color> colors;

  CustomCategoryDetails({
    super.key,
    required this.category,
    required this.title,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DisplayTasksByCategoryView(category: category));
      },
      child: Container(
        padding: EdgeInsetsDirectional.all(screenWidth(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: colors,
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppColors.whiteColor,
            ),
            CustomText(
              title,
              type: TextStyleType.SUBTITLE,
              textColor: AppColors.whiteColor,
            ),
            CustomText(
              "${tasksServices.filteredTasksWithCategory[category]!.length} tasks",
              type: TextStyleType.SMALL,
              textColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
