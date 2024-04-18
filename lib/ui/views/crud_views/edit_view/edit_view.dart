// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/crud_views/edit_view/edit_controller.dart';

class EditView extends StatelessWidget {
  final Task oldTask;
  EditView({
    super.key,
    required this.oldTask,
  });

  @override
  Widget build(BuildContext context) {
    EditController controller = Get.put(EditController());

    controller.taskTitleController.text = oldTask.title;

    controller.selectStartDate.value = oldTask.startDate;
    controller.selectEndDate.value = oldTask.endDate;

    controller.selectedPriority.value = oldTask.priority;
    controller.selectedCategory.value = oldTask.category;

    controller.isImportant.value = oldTask.important == 1;
    controller.isCompleted.value = oldTask.completed == 1;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            "Edit View",
            type: TextStyleType.TITLE,
          ),
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.all(
            screenWidth(20),
          ),
          child: Obx(
            () {
              return ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        "Priority:",
                        type: TextStyleType.BODY,
                      ),
                      DropdownButton<Priority>(
                        // hint: Text('Please choose a category'),
                        value: controller.selectedPriority.value,
                        items: Task.mapPrioritys.keys
                            .map((Priority choosenPriority) {
                          return DropdownMenuItem<Priority>(
                            value: choosenPriority,
                            child: CustomText(
                              Task.mapPrioritys[choosenPriority]!,
                              type: TextStyleType.BODY,
                            ),
                          );
                        }).toList(),
                        onChanged: (choosenPriority) {
                          controller.selectedPriority.value = choosenPriority!;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        "Category:",
                        type: TextStyleType.BODY,
                      ),
                      DropdownButton<Category>(
                        // hint: Text('Please choose a category'),
                        value: controller.selectedCategory.value,
                        items: Task.mapCategorys.keys
                            .map((Category choosenCategory) {
                          return DropdownMenuItem<Category>(
                            value: choosenCategory,
                            child: CustomText(
                              Task.mapCategorys[choosenCategory]!,
                              type: TextStyleType.BODY,
                            ),
                          );
                        }).toList(),
                        onChanged: (choosenCategory) {
                          controller.selectedCategory.value = choosenCategory!;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth(20)),
                  Form(
                    key: controller.formState,
                    child: CustomTextFormField(
                      validator: (p0) {
                        if (controller.taskTitleController.text.isEmpty) {
                          return "Enter yor task to do";
                        }
                        return null;
                      },
                      controller: controller.taskTitleController,
                      label: "Task Title",
                      hintText: "Enter what to do",
                    ),
                  ),
                  SizedBox(height: screenWidth(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        "Important:",
                        type: TextStyleType.BODY,
                      ),
                      IconButton(
                        onPressed: () {
                          controller.isImportant.value =
                              !controller.isImportant.value;
                        },
                        icon: Icon(
                          controller.isImportant.value
                              ? Icons.star
                              : Icons.star_border_outlined,
                          size: screenWidth(12),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenWidth(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        "Completed:",
                        type: TextStyleType.BODY,
                      ),
                      Checkbox(
                        value: controller.isCompleted.value,
                        onChanged: (value) {
                          controller.isCompleted.value = value!;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth(20)),
                  CustomText(
                    "Start Date",
                    type: TextStyleType.SUBTITLE,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth(1), screenWidth(7)),
                    ),
                    onPressed: () {
                      controller.startDateTimePickerWidget(context);
                    },
                    child: CustomText(
                      DateFormat('yyyy/MM/dd ---- HH:mm')
                          .format(controller.selectStartDate.value),
                      type: TextStyleType.BODY,
                    ),
                  ),
                  SizedBox(height: screenWidth(20)),
                  CustomText(
                    "End Date",
                    type: TextStyleType.SUBTITLE,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth(1), screenWidth(7)),
                    ),
                    onPressed: () {
                      controller.endDateTimePickerWidget(context);
                    },
                    child: CustomText(
                      DateFormat('HH:mm')
                          .format(controller.selectEndDate.value),
                      type: TextStyleType.BODY,
                    ),
                  ),
                  SizedBox(height: screenWidth(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(screenWidth(3), screenWidth(6)),
                          backgroundColor: AppColors.redColor,
                          elevation: 4,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: CustomText(
                          "Cancel",
                          type: TextStyleType.BODY,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(screenWidth(3), screenWidth(6)),
                          backgroundColor: AppColors.greenColor,
                          elevation: 4,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          controller.editTask(oldTask.id);
                        },
                        child: CustomText(
                          "Edit",
                          type: TextStyleType.BODY,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
