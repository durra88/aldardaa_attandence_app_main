// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AttendanceAnimationController extends GetxController
//     with GetTickerProviderStateMixin {
//   late AnimationController animationController;


//   @override
//   void onInit() {
//     animationController = AnimationController(
//         lowerBound: 0.0,
//         upperBound: 1.0,
//         vsync: this,
//         duration: const Duration(milliseconds: 150),
//         reverseDuration: const Duration(milliseconds: 400));
//     super.onInit();
//   }

// //!animate button
//   Future<void> animateButton() async {
//     animationController.forward(from: 0.0);
//     animationController.reverse(from: 0.8);
//     animationController.addListener(() {});
//   }

//   @override
//   void onClose() {
//     animationController.dispose();

//     super.onClose();
//   }

// //?------------------------------------------------------------------------------
// }
