import 'dart:developer';
import 'package:attendance_app/model/user_model.dart';
import 'package:quickalert/quickalert.dart';
import 'package:attendance_app/controller/attendance_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:attendance_app/controller/animation_controller.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/pages/camera/camera_preview_screen.dart';
import 'package:attendance_app/strings/home_string.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Container(
            height: screenHeight(context),
            width: screenWidth(context),
          ),
          Container(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight(context) / 40,
                ),
                Container(
                  height: screenHeight(context) / 2.5,
                  width: screenWidth(context) / 1.06,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            20.0), // Set the bottom-left corner radius
                        bottomRight: Radius.circular(20.0),
                      ),
                      color: AppColors.darkBlueColor),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Lottie.asset(
                      'images/lotties/one.json',
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) / 15,
                ),
                Container(
                  height: screenHeight(context) / 3.5,
                  width: screenWidth(context) / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35.0, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Attendance ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alata(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 45,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context) / 19,
                        ),
                        Text(
                          'Log-in to a great experience and easy way to confirm your attendance',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.alata(
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) / 18,
                ),
                Container(
                  height: screenHeight(context) / 10,
                  width: screenWidth(context) / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white38, width: 2),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: BouncingWidget(
                          scaleFactor: 1.0,
                          onPressed: () async {
                            // log("Date is mix ${_attendanceController.getCurrentDateTime()}");

                            await availableCameras().then((value) {
                              Get.to(
                                () => CameraPreviewScreen(
                                  cameras: value,
                                  isLogIn: true,
                                ),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500),
                              );

                              return value;
                            });
                          },
                          child: Container(
                            height: screenHeight(context) / 10,
                            width: screenWidth(context) / 2.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.darkBlueColor.withOpacity(1),
                                      AppColors.darkBlueColor,
                                    ]),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 4.0),
                                    spreadRadius: 4.0,
                                  )
                                ]),
                            child: Center(
                              child: appText(
                                "Log in",
                                color: Colors.white,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: BouncingWidget(
                          scaleFactor: 1.0,
                          onPressed: () async {
                            //showSammaryDialog(context);
                            await availableCameras().then(
                              (value) {
                                Get.to(
                                  () => CameraPreviewScreen(
                                    isLogIn: false,
                                    cameras: value,
                                  ),
                                  transition: Transition.downToUp,
                                  duration: const Duration(milliseconds: 500),
                                );
                                EasyLoading.dismiss();

                                return value;
                              },
                            );
                          },
                          child: Container(
                            height: screenHeight(context) / 10,
                            width: screenWidth(context) / 2.39,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white10.withOpacity(1),
                                      Colors.white10,
                                    ]),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 4.0),
                                    spreadRadius: 4.0,
                                  )
                                ]),
                            child: Center(
                              child: appText(
                                "Register",
                                color: Colors.black,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void showSammaryDialog(
  //   BuildContext context,
  //   // UserModel user,
  // ) {
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.custom,
  //     barrierDismissible: true,
  //     confirmBtnText: 'Confirm',
  //     customAsset: 'images/face2.jpeg',
  //     widget: Column(
  //       children: [
  //         height(20),
  //         Container(
  //           child: Text(
  //             'Durra ',
  //             textAlign: TextAlign.center,
  //             style: GoogleFonts.alata(
  //               fontWeight: FontWeight.w200,
  //               color: Colors.black,
  //               fontSize: 16,
  //             ),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               child: Text(
  //                 'check in ',
  //                 textAlign: TextAlign.center,
  //                 style: GoogleFonts.beVietnamPro(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               child: Text(
  //                 'oct 10 1998 ',
  //                 textAlign: TextAlign.center,
  //                 style: GoogleFonts.beVietnamPro(
  //                   fontWeight: FontWeight.w200,
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         height(8),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               child: Text(
  //                 'check out ',
  //                 textAlign: TextAlign.center,
  //                 style: GoogleFonts.beVietnamPro(
  //                   fontWeight: FontWeight.w200,
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               child: Text(
  //                 'oct 10 1998 ',
  //                 textAlign: TextAlign.center,
  //                 style: GoogleFonts.beVietnamPro(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         height(8),
  //       ],
  //     ),
  //     onConfirmBtnTap: () async {
  //       Get.back();
  //     },
  //     title: 'Summary',
  //     text: 'Attendance Tracking System',
  //   );
  // }
}
