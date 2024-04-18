import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class CreateController extends GetxController {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController taskTitleController = TextEditingController();

  Rx<DateTime> selectStartDate = DateTime.now().obs;
  Rx<DateTime> selectEndDate = DateTime.now().obs;
  Rx<bool> isImportant = false.obs;
  Rx<Category> selectedCategory = Category.personal.obs;
  Rx<Priority> selectedPriority = Priority.low.obs;

  startDateTimePickerWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: selectStartDate.value,
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      pickerMode: DateTimePickerMode.time,
      onConfirm: (dateTime, List<int> index) {
        selectStartDate.value = dateTime;
        selectEndDate.value = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          selectEndDate.value.hour,
          selectEndDate.value.minute,
        );
        // final selIOS =
        //     DateFormat('dd-MMM-yyyy - HH:mm').format(selectStartDate.value);
        // print(selIOS);
      },
    );
  }

  endDateTimePickerWidget(BuildContext context) {
    selectEndDate.value = selectStartDate.value;
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'HH:mm',
      initialDateTime: selectEndDate.value,
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      pickerMode: DateTimePickerMode.time,
      onConfirm: (dateTime, List<int> index) {
        selectEndDate.value = dateTime;
      },
    );
  }

  addTask() async {
    if (formState.currentState!.validate()) {
      int success = 0;
      if (selectStartDate.value.isBefore(selectEndDate.value)) {
        success = await tasksServices.insertTask(
          title: taskTitleController.text,
          startDate: selectStartDate.value,
          endDate: selectEndDate.value,
          priority: selectedPriority.value,
          category: selectedCategory.value,
          important: isImportant.value ? 1 : 0,
        );
      }
      if (success == 0) {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "The Task Title is empty",
        )..show();
      } else {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: "Success Add",
          desc: "the number of task task is $success",
        )..show();
      }
    }
  }
}
