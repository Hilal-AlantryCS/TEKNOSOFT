import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class MySearchController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<dynamic> tasks = <dynamic>[].obs;
  RxList<dynamic> searchTasks = [].obs;

  @override
  void onInit() {
    tasks.addAll(tasksServices.tasks);
    super.onInit();
  }

  void searchByString(String search) {
    if (search.isEmpty) {
      searchTasks.value = tasks;
    } else {
      searchTasks.value = tasks
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
    }
  }
}
