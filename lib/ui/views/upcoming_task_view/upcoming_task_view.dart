import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_floating_add.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_task_details.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';
import 'package:teknosoft/ui/views/upcoming_task_view/upcoming_task_controller.dart';

class UpcomingTaskView extends StatelessWidget {
  const UpcomingTaskView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UpcomingTaskController controller = Get.put(UpcomingTaskController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            "Upcoming",
            type: TextStyleType.TITLE,
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                controller.filterType.value = value;
              },
              itemBuilder: (BuildContext context) {
                return {'All Upcoming', 'filter in day'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Obx(
          () {
            return ListView(
              children: [
                TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(3000),
                  focusedDay: controller.filterDate.value,
                  weekendDays: const [DateTime.friday, DateTime.saturday],
                  calendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.blue),
                    weekNumberTextStyle: TextStyle(color: Colors.red),
                    weekendTextStyle: TextStyle(color: Colors.pink),
                    todayDecoration: BoxDecoration(
                      color: AppColors.blueColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.blueColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  onHeaderTapped: (focusedDay) {
                    controller.datePickerWidget(context);
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.filterDate.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.onDaySelected(selectedDay, focusedDay);
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(
                    screenWidth(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        controller.filterType.value,
                        type: TextStyleType.SUBTITLE,
                      ),
                      DropdownButton<String>(
                        // hint: Text('Please choose a category'),
                        value: controller.filterType.value,
                        items: {'All Upcoming', 'filter in day'}
                            .map((String choice) {
                          return DropdownMenuItem<String>(
                            value: choice,
                            child: CustomText(
                              choice,
                              type: TextStyleType.BODY,
                            ),
                          );
                        }).toList(),
                        onChanged: (choice) {
                          controller.filterType.value = choice!;
                        },
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.filterType.value == "All Upcoming"
                      ? tasksServices.upcomingTasks.length
                      : tasksServices.filterTask.length,
                  itemBuilder: (context, index) {
                    Task myTask = controller.filterType.value == "All Upcoming"
                        ? tasksServices.upcomingTasks[index]
                        : tasksServices.filterTask[index];
                    return CustomTaskDetails(myTask: myTask);
                  },
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
