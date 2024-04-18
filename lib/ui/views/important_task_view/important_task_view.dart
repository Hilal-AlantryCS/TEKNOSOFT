import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_task_details.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class ImportantView extends StatelessWidget {
  const ImportantView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            "MyDay",
            type: TextStyleType.TITLE,
          ),
        ),
        body: Obx(
          () {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tasksServices.importantTasks.length,
              itemBuilder: (context, index) {
                Task myTask = tasksServices.importantTasks[index];
                return CustomTaskDetails(myTask: myTask);
              },
            );
          },
        ),
      ),
    );
  }
}
