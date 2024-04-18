import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class DisplayTasksByCategoryController extends GetxController {
  Rx<DateTime> filterDate = DateTime.now().obs;
  Rx<Category> category = Category.personal.obs;

  updateCategory(Category uiCategory) {
    category.value = uiCategory;
  }

  datePickerWidget(BuildContext context) async {
    filterDate.value = await showDatePicker(
          context: context,
          initialDate: filterDate.value,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
        ) ??
        filterDate.value;
    print(filterDate.value);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    filterDate.value = selectedDay;
    tasksServices.onDaySelected(selectedDay, focusedDay, category.value);
  }
}
