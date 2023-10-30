import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:attendance_app/pages/widget/close_button_widget.dart';
import 'package:attendance_app/pages/widget/custom_button_widget.dart';
import 'package:attendance_app/pages/widget/on_tap_hide_keyboard.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:attendance_app/controller/attendance_controller.dart';
import 'package:attendance_app/machine_learning/tflite_recognizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:lottie/lottie.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/pages/main_screens/login_screen.dart';
import 'package:attendance_app/pages/widget/textfield_widget.dart';
import 'package:attendance_app/strings/home_string.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({
    super.key,
    required this.croopedFace,
    required this.recognition,
  });
  final img.Image? croopedFace;
  final UserModel? recognition;

  @override
  Widget build(BuildContext context) {
    AttendanceController attendanceController = Get.put(AttendanceController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBlueColor,
      body: OnTapHideKeyBoard(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: screenHeight(context),
                        maxWidth: screenWidth(context)),
                    child: Column(
                      children: [
                        const Spacer(),
                        appText("Create Account ",
                            textStyle: GoogleFonts.beVietnamPro(
                              fontSize: 30,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                        height(2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: appText(
                              "Experience hassle-free attendance tracking by creating your account below. ",
                              textStyle: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                color: AppColors.greenColor,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        height(16),
                        Stack(
                          children: [
                            Column(
                              children: [
                                height(100),
                                Container(
                                  alignment: Alignment.center,
                                  height: screenHeight(context) * 0.5,
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      height(10),
                                      TextFieldWidget(
                                        onChange: (value) {
                                          if (value!.isEmpty) {
                                            return "The name can not be empty";
                                          }
                                        },
                                        icon: Icons.person,
                                        hintText: "Name",
                                        controller: attendanceController
                                            .nameController.value,
                                      ),
                                      height(10),
                                      TextFieldWidget(
                                        onChange: (value) {
                                          final bool isValid =
                                              EmailValidator.validate(value!);
                                          if (isValid == false) {
                                            return "Please insert a valid Email";
                                          }
                                        },
                                        icon: Icons.email,
                                        hintText: "Email",
                                        controller: attendanceController
                                            .emailController.value,
                                      ),
                                      height(30),
                                      SizedBox(
                                        width: screenWidth(context),
                                        child: Center(
                                            child: AnimatedLogInButton(
                                          onTap: () {
                                            log("google ${attendanceController.emailController.value.text}");
                                            TfliteRecognizer.registeredFacesMap.putIfAbsent(
                                                attendanceController
                                                    .nameController.value.text,
                                                () => UserModel(
                                                    name: attendanceController
                                                        .nameController
                                                        .value
                                                        .text,
                                                    location:
                                                        recognition!.location,
                                                    embeddings:
                                                        recognition!.embeddings,
                                                    distance:
                                                        recognition!.distance,
                                                    email: attendanceController
                                                        .emailController
                                                        .value
                                                        .text,
                                                    checkIn: '',
                                                    checkOut: ''));

                                            EasyLoading.showSuccess(
                                                successMessage);
                                            Get.to(
                                              () => const LogInPage(),
                                              transition:
                                                  Transition.rightToLeft,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            );
                                          },
                                          title: "Submit",
                                          buttonColor: AppColors.lightRedColor,
                                        )),
                                      ),
                                      height(20)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 50,
                              child: SizedBox(
                                width: screenWidth(context),
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.darkBlueColor,
                                    radius: 80, // Set the radius of the circle
                                    child: ClipOval(
                                      child: Image.memory(
                                        Uint8List.fromList(
                                            img.encodeBmp(croopedFace!)),
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                        height: double.maxFinite,
                                      ),
                                    ), // Provide the path to your image asset
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        height(80),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 10,
                top: 20,
                child: CloseButtonWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
