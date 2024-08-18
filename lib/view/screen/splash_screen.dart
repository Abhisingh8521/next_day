import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors/colors.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
          () {
        Get.offAll(() => const HomeScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
              "assets/images/nextday.png",
              width: 80,
              height: 80,
            ),
            SizedBox(height: 20,),
            Text("Next Day Technology",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 20),)
        ],

        ),
      )
    );
  }
}
