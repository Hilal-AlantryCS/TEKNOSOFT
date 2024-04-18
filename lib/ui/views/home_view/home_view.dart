import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_category_details.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_floating_add.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_list_tile_button.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/important_task_view/important_task_view.dart';
import 'package:teknosoft/ui/views/my_day_task_view/my_day_task_view.dart';
import 'package:teknosoft/ui/views/search_view/search_view.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            "lists",
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(SearchView());
                            },
                            icon: Icon(
                              Icons.search,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircularProgressIndicator(
                            value: tasksServices.progressMyDayTasks.length /
                                tasksServices.myDayTasks.length,
                          ),
                          CustomText(
                            "Today\'s Progress ",
                          ),
                          CustomText(
                            "${tasksServices.progressMyDayTasks.length} tasks left",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.all(screenWidth(20)),
                  padding: EdgeInsetsDirectional.all(screenWidth(20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    children: [
                      CustomListTileButton(
                        title: "My Day",
                        subTitle: "${tasksServices.myDayTasks.length} tasks",
                        icon: Icons.sunny,
                        onTap: () {
                          Get.to(MyDayTaskView());
                        },
                      ),
                      Divider(height: 0),
                      CustomListTileButton(
                        title: "Upcoming",
                        subTitle: "${tasksServices.upcomingTasks.length} tasks",
                        icon: Icons.calendar_month_outlined,
                        onTap: () {
                          Get.to(UpcomingTaskView());
                        },
                      ),
                      Divider(height: 0),
                      CustomListTileButton(
                        title: "Important",
                        subTitle:
                            "${tasksServices.importantTasks.length} tasks",
                        icon: Icons.star,
                        onTap: () {
                          Get.to(ImportantView());
                        },
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
