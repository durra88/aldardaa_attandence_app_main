import 'package:attendance_app/controller/drawer_controller.dart';
import 'package:attendance_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/pages/introduction_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put<MyDrawerController>(MyDrawerController());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.darkBlueColor,
    ),
  );

  await GetStorage.init();

  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: AppColors.darkBlueColor),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
          backgroundColor: AppColors.darkBlueColor, body: SplashScreen()),
    );
  }
}
