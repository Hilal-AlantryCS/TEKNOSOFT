import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/enums/text_style_type.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/shared/custom_widgets/custom_text.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class MyDayTaskView extends StatelessWidget {
  const MyDayTaskView({super.key});

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
              itemCount: tasksServices.myDayTasks.length,
              itemBuilder: (context, index) {
                Task myTask = tasksServices.myDayTasks[index];
                bool isComplete = (myTask.completed == 1);
                return Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: screenWidth(20),
                    vertical: screenWidth(50),
                  ),
                  height: screenWidth(3),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      extentRatio: 0.5,
                      motion: BehindMotion(),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.greenColor.withOpacity(0.2),
                          ),
                          alignment: Alignment.center,
                          width: screenWidth(6),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth(20)),
                        Container(
                          alignment: Alignment.center,
                          width: screenWidth(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.redColor.withOpacity(0.2),
                          ),
                          child: IconButton(
                            onPressed: () {
                              tasksServices.deleteTask(
                                id: myTask.id,
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.redColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 6.0),
                      padding: EdgeInsets.all(screenWidth(35)),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isComplete,
                            onChanged: (value) {
                              if (value!) {
                                tasksServices.updateTask(
                                  id: myTask.id,
                                  category: myTask.category,
                                  endDate: myTask.endDate,
                                  important: myTask.important,
                                  priority: myTask.priority,
                                  startDate: myTask.startDate,
                                  title: myTask.title,
                                  completed: myTask.completed + 1,
                                );
                              } else {
                                tasksServices.updateTask(
                                  id: myTask.id,
                                  category: myTask.category,
                                  endDate: myTask.endDate,
                                  important: myTask.important,
                                  priority: myTask.priority,
                                  startDate: myTask.startDate,
                                  title: myTask.title,
                                  completed: myTask.completed - 1,
                                );
                              }
                              isComplete = !value;
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                myTask.title,
                                type: TextStyleType.SUBTITLE,
                                textColor: AppColors.blueColor,
                              ),
                              Spacer(),
                              CustomText(
                                "${myTask.startDate.hour}:${myTask.startDate.minute} - ${myTask.endDate.hour}:${myTask.endDate.minute}",
                                type: TextStyleType.SMALL,
                                textColor: AppColors.greyColor,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Container(
                                    height: screenWidth(20),
                                    width: screenWidth(20),
                                    decoration: BoxDecoration(
                                      color: AppColors
                                          .category[myTask.category.index][1],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    margin: EdgeInsetsDirectional.only(
                                      end: screenWidth(30),
                                    ),
                                  ),
                                  CustomText(
                                    Task.mapCategorys[myTask.category]!,
                                    type: TextStyleType.BODY,
                                    textColor: AppColors.darkGreyColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              if (myTask.important == 0) {
                                tasksServices.updateTask(
                                  id: myTask.id,
                                  title: myTask.title,
                                  startDate: myTask.startDate,
                                  endDate: myTask.endDate,
                                  priority: myTask.priority,
                                  category: myTask.category,
                                  important: myTask.important + 1,
                                  completed: myTask.completed,
                                );
                              } else {
                                tasksServices.updateTask(
                                  id: myTask.id,
                                  title: myTask.title,
                                  startDate: myTask.startDate,
                                  endDate: myTask.endDate,
                                  priority: myTask.priority,
                                  category: myTask.category,
                                  important: myTask.important - 1,
                                  completed: myTask.completed,
                                );
                              }
                            },
                            icon: Icon(
                              myTask.important != 0
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              size: screenWidth(12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
