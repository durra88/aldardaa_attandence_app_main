import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/strings/introduction_string.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final pages = [
  PageViewModel(
    bubbleBackgroundColor: const Color.fromARGB(255, 77, 77, 77),
    pageBackground: SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      //color: ,
      child: Container(
        height: double.maxFinite,
        alignment: Alignment.center,
        color: AppColors.lightBlack,
        child: Image.asset(
          "images/face4.gif",
          fit: BoxFit.fill,
        ),
      ),
    ),
    body: Container(
      margin: const EdgeInsets.only(top: 30),
      child: appText(
        firstIntrContentText,
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.acme(
          fontSize: 16,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ),
  PageViewModel(
    mainImage: Lottie.asset(
      "images/lotties/face_scan.json",
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    // pageBackground: const SizedBox(
    //   width: double.maxFinite,
    //   height: double.maxFinite,

    //   //color: ,
    //   child: Center(
    //     child: Text("ad"),
    //   ),
    //  Container(
    //   height: double.maxFinite,
    //   alignment: Alignment.center,
    //   color: AppColors.lightBlack,
    //   child: Image.asset(
    //     "images/face3.jpeg",
    //     // height: double.maxFinite,
    //     fit: BoxFit.fill,
    //   ),
    // ),
    // ),
    title: appText(
      secondIntrTitleText,
      textAlign: TextAlign.center,
      textStyle: GoogleFonts.acme(
        fontSize: 16,
        color: AppColors.blackColor,
        fontWeight: FontWeight.normal,
      ),
    ),
    bubbleBackgroundColor: AppColors.darkBlueColor,
    pageColor: AppColors.whiteColor,
    body: appText(
      secondIntrContentText,
      textAlign: TextAlign.center,
      textStyle: GoogleFonts.acme(
        fontSize: 16,
        color: AppColors.blackColor,
        fontWeight: FontWeight.normal,
      ),
    ),
  ),
  PageViewModel(
    title: AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          thirdIntrTitleTextt,
          textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor),
          speed: const Duration(milliseconds: 200),
        ),
      ],
      totalRepeatCount: 4,
      pause: const Duration(milliseconds: 1000),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    ),
    mainImage: Image.asset(
      "images/face_Illustration.jpeg",
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    bubbleBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
    body: appText(
      thirdIntrContentText,
      textAlign: TextAlign.center,
      textStyle: GoogleFonts.acme(
        fontSize: 18,
        color: AppColors.blackColor,
        fontWeight: FontWeight.normal,
      ),
    ),
  ),
];
