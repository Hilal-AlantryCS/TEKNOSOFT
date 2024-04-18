import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:teknosoft/core/services/tasks_service.dart';

void customLoader() => BotToast.showCustomLoading(
      toastBuilder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 103, 103).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          width: screenWidth(4),
          height: screenWidth(4),
          child: SpinKitCircle(
            size: screenWidth(8),
          ),
        );
      },
    );

double screenWidth(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.width / percent;
  else
    return Get.size.height / percent;
}

double screenHeight(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.height / percent;
  else
    return Get.size.width / percent;
}

TasksServices get tasksServices => Get.find<TasksServices>();
