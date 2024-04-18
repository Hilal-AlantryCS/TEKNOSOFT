import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/crud_views/create_view/create_view.dart';

class CustomFloatingAdd extends StatelessWidget {
  final Category? category;
  const CustomFloatingAdd({
    super.key,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(5.5),
      height: screenWidth(5.5),
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 12,
          onPressed: () {
            Get.to(
              CreateView(
                category: category,
              ),
            );
          },
          backgroundColor: AppColors.blueColor,
          child: Icon(
            size: screenWidth(15),
            Icons.add,
          ),
        ),
      ),
    );
  }
}
