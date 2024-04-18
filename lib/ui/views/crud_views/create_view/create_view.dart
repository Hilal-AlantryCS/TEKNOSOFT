// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/crud_views/create_view/create_controller.dart';

class CreateView extends StatelessWidget {
  final Category? category;
  CreateView({
    super.key,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    CreateController controller = Get.put(CreateController());
    controller.selectedCategory.value = category ?? Category.personal;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () {
              return CustomText(
                Task.mapCategorys[controller.selectedCategory.value]!,
                type: TextStyleType.TITLE,
              );
            },
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth(1), screenWidth(6)),
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      controller.addTask();
                    },
                    child: CustomText(
                      "Add",
                      type: TextStyleType.BODY,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
