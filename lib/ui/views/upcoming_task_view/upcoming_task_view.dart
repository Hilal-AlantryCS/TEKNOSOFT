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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
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
                SizedBox(height: screenWidth(20)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tasksServices.filterTask.length,
                  itemBuilder: (context, index) {
                    Task myTask = tasksServices.filterTask[index];
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
