import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_floating_add.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_task_details.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class DisplayTasksByCategoryView extends StatelessWidget {
  final Category category;
  const DisplayTasksByCategoryView({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            Task.mapCategorys[category]!,
            type: TextStyleType.TITLE,
          ),
           centerTitle: true,
        ),
        body: Obx(
          () {
            return ListView(
              children: [
                SizedBox(height: screenWidth(20)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      tasksServices.filteredTasksWithCategory[category]!.length,
                  itemBuilder: (context, index) {
                    Task myTask = tasksServices
                        .filteredTasksWithCategory[category]![index];
                    return CustomTaskDetails(myTask: myTask);
                  },
                ),
              ],
            );
          },
        ),
        floatingActionButton: CustomFloatingAdd(
          category: category,
        ),
      ),
    );
  }
}
