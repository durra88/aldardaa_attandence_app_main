import 'package:attendance_app/controller/camera_preview_controller.dart';
import 'package:attendance_app/controller/drawer_controller.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:attendance_app/pages/main_screens/login_screen.dart';
import 'package:attendance_app/pages/main_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class MenuScreen extends GetView<MyDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CameraPreviewController previewController =
        Get.put(CameraPreviewController());
    UserModel user = previewController.userModel.value;
    return Scaffold(
      backgroundColor: AppColors.darkBlueColor, //0xFF1E55C4
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 0,
                        ),
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundColor:
                              const Color.fromARGB(205, 5, 109, 181),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset("images/face1.jpeg",
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18, left: 10),
                        child: Text(
                          '${user.name} ',
                          style: GoogleFonts.abhayaLibre(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                controller.toggleDrawer();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Profile ',
                      style: GoogleFonts.abel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Get.to(() => const ProfileScreen());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Attendance ',
                      style: GoogleFonts.abel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Get.to(() => const ProfileScreen());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Notification ',
                      style: GoogleFonts.abel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Get.to(() => const ProfileScreen());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.help_sharp,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Help ',
                      style: GoogleFonts.abel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Get.to(() => const ProfileScreen());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'About ',
                      style: GoogleFonts.abel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            // Divider(thickness: 0.3, color: Colors.white.withOpacity(0.2)),

            InkWell(
              onTap: () {
                Get.to(() => const ProfileScreen());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Rate us ',
                      style: GoogleFonts.abel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            //?--------------------------------------------------------------------------LogOUt
            InkWell(
              onTap: () {
                Get.to(() => const LogInPage());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Log out ',
                      style: GoogleFonts.abel(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
