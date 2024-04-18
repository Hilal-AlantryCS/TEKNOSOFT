import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/app/my_app.dart';
import 'package:teknosoft/core/services/tasks_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(TasksServices());

  runApp(MyApp());
}
