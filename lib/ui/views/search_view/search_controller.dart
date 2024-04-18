import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/ui/shared/utils.dart';

class MySearchController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<dynamic> filtertask = [].obs;
  RxList<dynamic> searchTasks = [].obs;

  @override
  void onInit() {
    tasksServices.tasks.forEach((element) {
      filtertask.add(element);
    });
    // filtertask.addAll(tasksServices.tasks);
    super.onInit();
  }

  void searchByString(String search) {
    if (search.isEmpty) {
      searchTasks = filtertask;
    } else {
      searchTasks.value = filtertask
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
    }
  }
}
