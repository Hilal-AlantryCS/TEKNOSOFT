import 'package:get/get.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class HomeController extends GetxController {
  RxDouble todayProgress = 0.0.obs;

  @override
  void onInit() {
    if (tasksServices.myDayTasks.length != 0) {
      todayProgress.value = tasksServices.progressMyDayTasks.length /
          tasksServices.myDayTasks.length;
    } else {
      todayProgress.value = 0.0;
    }
    super.onInit();
  }
}
