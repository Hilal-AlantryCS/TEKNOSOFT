import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class UpcomingTaskController extends GetxController {
  Rx<DateTime> filterDate = DateTime.now().obs;
  Rx<String> filterType = "All Upcoming".obs;

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
    tasksServices.updateFilteredUpcomingTaskOnDaySelected(
        selectedDay, focusedDay);
  }
}
