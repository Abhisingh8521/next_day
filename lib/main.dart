
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_day/utils/themes/app_themes.dart';
import 'package:next_day/view/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     theme: AppTheme.darkTheme(context),
      home:  SplashScreen(),
    );
  }
}
