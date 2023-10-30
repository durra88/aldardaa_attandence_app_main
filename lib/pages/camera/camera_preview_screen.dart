import 'dart:developer';
import 'package:attendance_app/controller/camera_preview_controller.dart';
import 'package:attendance_app/machine_learning/tflite_recognizer.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:attendance_app/controller/attendance_controller.dart';
import 'package:attendance_app/pages/camera/face_recognition_widget.dart';
import 'package:attendance_app/pages/drawer/drawer_navigation.dart';
import 'package:attendance_app/pages/widget/attendance_summary_widget.dart';
import 'package:attendance_app/pages/widget/close_button_widget.dart';
import 'package:attendance_app/pages/widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:attendance_app/pages/main_screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:attendance_app/controller/animation_controller.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/pages/main_screens/registration_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:quickalert/quickalert.dart';

class CameraPreviewScreen extends StatefulWidget {
  CameraPreviewScreen(
      {super.key,
      this.isCheckOut = false,
      this.isLogIn = true,
      required this.cameras});
  bool isLogIn, isCheckOut;
  List<CameraDescription> cameras;

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  final CameraPreviewController _previewController =
      Get.put(CameraPreviewController());

  late CameraController cameraController;
  bool isBusy = false;
  late bool isExistUser;
  late img.Image croppedFace;
  bool register = false;
  late UserModel userModel;
  late CameraDescription cameraDescription;

  @override
  void initState() {
    if (widget.cameras.length > 1) {
      cameraController =
          CameraController(widget.cameras[1], ResolutionPreset.high);
      cameraDescription = widget.cameras[1];
    } else {
      cameraController =
          CameraController(widget.cameras[0], ResolutionPreset.high);
      cameraDescription = widget.cameras[0];
    }
    log("beti ${widget.cameras.length} snd is = ${widget.cameras[0]},&& , ${widget.cameras[0]}");

    super.initState();
    isExistUser = widget.isLogIn;
    _initializeCamera();
  }

  _initializeCamera() async {
    await cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }

      cameraController.startImageStream((image) => {
            if (!_previewController.isBusy.value)
              {
                _previewController.isBusy.value = true,
                _previewController.doFaceDetectionOnFrame(
                    frame: image, description: cameraDescription)
              }
          });
      setState(() {});
    }).catchError(
      (e) {
        log("xox error camera $e");
      },
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetX<CameraPreviewController>(builder: (previewController) {
        return Container(
            alignment: Alignment.center,
            height: screenHeight(context),
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: (cameraController.value.isInitialized)
                        ? Column(
                            children: [
                              SizedBox(
                                width: screenWidth(context),
                                height: screenHeight(context),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CameraPreview(cameraController),
                                  ),
                                ),
                              ),
                              height(10),
                            ],
                          )
                        : SizedBox(
                            width: screenWidth(context),
                            height: screenHeight(context),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                  ),
                  if ((cameraController.value.isInitialized))
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      width: screenWidth(context),
                      height: screenHeight(context),
                      child: FaceRecognitonScreen(
                        cameraController: cameraController,
                      ),
                    ),
                  isExistUser == false
                      ? Positioned(
                          bottom: 20,
                          child: SizedBox(
                            width: screenWidth(context),
                            child: Center(
                                child: AnimatedLogInButton(
                                    onTap: () {
                                      croppedFace =
                                          _previewController.croppedFace;
                                      register = true;
                                      if (previewController
                                              .userModel.value.name ==
                                          "Unknown") {
                                        Get.to(
                                          () => RegistrationScreen(
                                            croopedFace: croppedFace,
                                            recognition: _previewController
                                                .userModel.value,
                                          ),
                                        );
                                      } else {
                                        displaySnackBar(context,
                                            title:
                                                "Warning: User Already Exists",
                                            message:
                                                "It appears you already have account registered Please log in! ",
                                            backgroundColor: Colors.red,
                                            icon: Icons.warning);
                                      }

                                      register = false;
                                    },
                                    title: "Register")),
                          ),
                        )
                      : Positioned(
                          bottom: 20,
                          child: SizedBox(
                            width: screenWidth(context),
                            child: Center(
                                child: AnimatedLogInButton(
                              onTap: () {
                                if (previewController.userModel.value.name ==
                                    "Unknown") {
                                  displaySnackBar(context,
                                      title: "Unauthorized Access Detected!",
                                      message:
                                          "Ooops! It looks like you don't have permission, ",
                                      backgroundColor: Colors.red,
                                      icon: Icons.warning);
                                } else {
                                  if (widget.isCheckOut == false) {
                                    displaySnackBar(context,
                                        title: "Check in Successful! ",
                                        message:
                                            "You have been successfully check in aboard! Fell free to explore more.");
                                    previewController.userModel.value.checkIn =
                                        previewController.checkIn.value =
                                            previewController
                                                .getCurrentDateTime();

                                    Get.to(() => const MenuHomeNavigation());
                                  } else {
                                    previewController.userModel.value.checkOut =
                                        previewController.getCurrentDateTime();
                                    showSummaryDialog(
                                        context,
                                        previewController.userModel.value,
                                        previewController);
                                  }
                                }
                              },
                              title: widget.isCheckOut == false
                                  ? "Check in"
                                  : "Check out",
                            )),
                          ),
                        ),
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      width: screenWidth(context),
                      child: Container(
                        padding: const EdgeInsets.only(top: 40, bottom: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.blackColor.withOpacity(0.4)),
                        child: Text(
                          ' ${previewController.userModel.value.name} ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.alata(
                            fontWeight: FontWeight.bold,
                            color: AppColors.backgroundColor,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 40,
                    left: 10,
                    child: CloseButtonWidget(),
                  ),
                ],
              ),
            ));
      }),
    );
  }

  void showSummaryDialog(
    BuildContext context,
    UserModel user,
    CameraPreviewController controller,
  ) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      borderRadius: 8,
      showCancelBtn: true,
      confirmBtnText: 'Confirm',
      confirmBtnColor: AppColors.greenColor,
      customAsset: 'images/face2.jpeg',
      widget: AttendenceSummaryWidget(controller: controller, user: user),
      onConfirmBtnTap: () async {
        displaySnackBar(context,
            title: "Check out Successful! ",
            message: "You have been successfully check out aboard!.");
        Get.to(() => const LogInPage());
      },
      title: 'Summary',
      text: 'Attendance Tracking System',
    );
  }
}
