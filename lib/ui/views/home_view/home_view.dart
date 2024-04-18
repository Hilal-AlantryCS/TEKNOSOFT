import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_category_details.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_floating_add.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/my_day_task_view/my_day_task_view.dart';
import 'package:teknosoft/ui/views/upcoming_task_view/upcoming_task_view.dart';

const List<IconData> categryIcon = [
  Icons.person,
  Icons.edit_outlined,
  Icons.work_outlined,
  Icons.shopping_bag_outlined,
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () {
            return ListView(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.all(screenWidth(20)),
                  padding: EdgeInsetsDirectional.all(screenWidth(20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(MyDayTaskView());
                        },
                        child: ListTile(
                          title: CustomText(
                            "My Day",
                            type: TextStyleType.SUBTITLE,
                            textColor: AppColors.blueColor,
                          ),
                          subtitle: CustomText(
                            "${tasksServices.myDayTasks.length} tasks",
                            type: TextStyleType.SMALL,
                          ),
                          leading: Icon(
                            Icons.sunny,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                      Divider(
                        height: 0,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(UpcomingTaskView());
                        },
                        child: ListTile(
                          title: CustomText(
                            "Upcoming",
                            type: TextStyleType.SUBTITLE,
                            textColor: AppColors.blueColor,
                          ),
                          subtitle: CustomText(
                            "${tasksServices.upcomingTasks.length} tasks",
                            type: TextStyleType.SMALL,
                          ),
                          leading: Icon(
                            Icons.sunny,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                      Divider(
                        height: 0,
                      ),
                      ListTile(
                        title: CustomText(
                          "Important",
                          type: TextStyleType.SUBTITLE,
                          textColor: AppColors.blueColor,
                        ),
                        subtitle: CustomText(
                          "${tasksServices.importantTasks.length} tasks",
                          type: TextStyleType.SMALL,
                        ),
                        leading: Icon(
                          Icons.sunny,
                          color: AppColors.blueColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.all(screenWidth(20)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: screenWidth(20),
                      mainAxisSpacing: screenWidth(20),
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Category.values.length,
                    itemBuilder: (context, index) {
                      return CustomCategoryDetails(
                        category: Category.values[index],
                        title: Task.mapCategorys[Category.values[index]]!,
                        icon: categryIcon[index],
                        colors: AppColors.category[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: CustomFloatingAdd(),
      ),
    );
  }
}
