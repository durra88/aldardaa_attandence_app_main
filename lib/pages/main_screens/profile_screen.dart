import 'package:attendance_app/controller/camera_preview_controller.dart';
import 'package:attendance_app/controller/drawer_controller.dart';
import 'package:attendance_app/controller/internet_controller.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:attendance_app/pages/connectivity/internet_connection_screen.dart';
import 'package:attendance_app/pages/camera/camera_preview_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:im_animations/im_animations.dart';
import 'package:image/image.dart' as img;
import 'package:showcaseview/showcaseview.dart';

class ProfileScreen extends GetView<MyDrawerController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ConnectivityController connectivityController =
        Get.put(ConnectivityController());
    CameraPreviewController previewController =
        Get.put(CameraPreviewController());
    UserModel user = previewController.userModel.value;
    GlobalKey one = GlobalKey();
    return ShowCaseWidget(
      builder: Builder(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context).startShowCase([
                  one,
                ]));
        return Scaffold(
          backgroundColor: AppColors.darkBlueColor,
          body: Obx(
            () => connectivityController.connectionStatus.value == 9
                ? const CheckInternetWidget()
                : SizedBox(
                    width: screenWidth(context),
                    height: screenHeight(context),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 38.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Showcase(
                                    key: one,
                                    description:
                                        'Click here to see animated menu options and you can logout to the main page.',
                                    child: Sonar(
                                      radius: 27,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            controller.toggleDrawer();
                                          },
                                          icon: const Icon(
                                            Icons.menu,
                                            color: AppColors.whiteColor,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Profile ',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.alata(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                      fontSize: 30,
                                    ),
                                  ),
                                  AnimatedIconButton(
                                    size: 18,
                                    onPressed: () {},
                                    duration: const Duration(milliseconds: 500),
                                    splashColor: Colors.transparent,
                                    icons: const <AnimatedIconItem>[
                                      AnimatedIconItem(
                                        icon: Icon(
                                          Icons.notification_add,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                      AnimatedIconItem(
                                        icon: Icon(
                                          Icons.close,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              height(40),
                              Text(
                                'Welcome to the attandence profile',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bellota(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Enjoy the experience',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bellota(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: ClipPath(
                            clipper: RoundedDiagonalPathClipper(),
                            child: Container(
                              height: screenHeight(context) - 220,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(0.0),
                                ),
                                color: AppColors.whiteColor,
                              ),
                              child: const Center(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 220,
                          left: 20,
                          child: SizedBox(
                            width: screenWidth(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.darkBlueColor,
                                  radius: 60, // Set the radius of the circle
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 8, right: 4),
                                    //decoration: BoxDecoration(),
                                    child: ClipOval(
                                      child: Image.memory(
                                        Uint8List.fromList(img.encodeBmp(
                                            previewController.croppedFace)),
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                        height: double.maxFinite,
                                      ),
                                    ),
                                  ), // Provide the path to your image asset
                                ),
                                height(0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    ' ${user.name}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.alata(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                height(4),
                                Text(
                                  ' ${user.email}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.alata(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                                height(30),
                                Container(
                                  width: screenWidth(context) * 0.9,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: screenWidth(context) * 0.4,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppColors.whiteColor
                                                      .withOpacity(1),
                                                  AppColors.whiteColor,
                                                ]),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 15.0,
                                                offset: Offset(0.0, 4.0),
                                                spreadRadius: 4.0,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Text(
                                                'Check in',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.arbutusSlab(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Text(
                                                ' ${previewController.checkIn.value}',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.arbutusSlab(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth(context) * 0.4,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppColors.whiteColor
                                                      .withOpacity(1),
                                                  AppColors.whiteColor,
                                                ]),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 15.0,
                                                offset: Offset(0.0, 4.0),
                                                spreadRadius: 4.0,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Text(
                                                'Check Out',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.arbutusSlab(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Text(
                                                // "", ${useruser.email}
                                                '${user.checkOut == "" ? "Not yet" : previewController.userModel.value.checkOut} ',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.arbutusSlab(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: screenWidth(context) * 0.11,
                          child: BouncingWidget(
                            scaleFactor: 1.0,
                            onPressed: () async {
                              await availableCameras().then((value) {
                                // _attendanceController.userData.value.checkOut =
                                //     _attendanceController.getCurrentDateTime();
                                Get.to(
                                  () => CameraPreviewScreen(
                                    isCheckOut: true,
                                    isLogIn: true,
                                    cameras: value,
                                  ),
                                  transition: Transition.upToDown,
                                  duration: const Duration(milliseconds: 700),
                                );

                                return value;
                              });
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
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
                                  "Check out",
                                  color: AppColors.whiteColor,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      }),
    );
  }
}
