// ignore_for_file: file_names

import 'package:attendance_app/controller/drawer_controller.dart';
import 'package:attendance_app/pages/drawer/menu.dart';
import 'package:attendance_app/pages/main_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class MenuHomeNavigation extends GetView<MyDrawerController> {
  const MenuHomeNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: GetBuilder<MyDrawerController>(builder: (_) {
        return GetBuilder<MyDrawerController>(
            builder: (_) => ZoomDrawer(
                  style: DrawerStyle.style3,
                  controller: _.zoomDrawerController,
                  menuScreen: const MenuScreen(),
                  mainScreen: ProfileScreen(),
                  borderRadius: 40,
                  showShadow: true,
                  angle: -4.0,
                  menuScreenOverlayColor: Colors.orangeAccent,

                  menuBackgroundColor: Colors.white,
                  slideWidth: MediaQuery.of(context).size.width * 0.65,

                  openCurve: Curves.bounceInOut,
                  closeCurve: Curves.ease,
                  //   mainScreenTapClose: true,
                ));
      })),
    );
  }
}
