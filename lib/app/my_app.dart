import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teknosoft/ui/shared/colors.dart';
import 'package:teknosoft/ui/views/home_view/home_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode theme;

  @override
  void initState() {
    super.initState();
    theme = ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'teknosoft',
      themeMode: theme,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          color: AppColors.blueColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColors.blueColor,
          ),
        )),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blueColor,
        ),
      ),
      home: HomeView(),
    );
  }
}
