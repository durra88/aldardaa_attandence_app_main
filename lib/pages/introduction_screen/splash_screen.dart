import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/pages/main_screens/login_screen.dart';
import 'package:attendance_app/pages/introduction_screen/introduction_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userLocalStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    userLocalStorage.writeIfNull('isLogged', false);
    Future.delayed(const Duration(microseconds: 3), () async {
      _checkifLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlueColor,
      body: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Center(
          child: Image.asset(
            'images/motf.png',
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }

  void _checkifLogged() {
    userLocalStorage.read('isLogged')
        ? Get.offAll(
            () => const LogInPage(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
          )
        : Get.offAll(
            () => Builder(
              builder: (context) => IntroViewsFlutter(
                pages,
                pageButtonTextStyles: const TextStyle(
                  color: AppColors.darkBlueColor,
                  fontSize: 16.0,
                  fontFamily: 'Regular',
                ),
                pageButtonTextSize: 11,
                showSkipButton: false,
                onTapDoneButton: () {
                  Get.to(
                    const LogInPage(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
              ),
            ),
          );

    userLocalStorage.write('isLogged', true);
  }
}
