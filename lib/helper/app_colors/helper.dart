import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';

SizedBox height(double height) {
  return SizedBox(height: height);
}

SizedBox width(double width) {
  return SizedBox(width: width);
}

double screenHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
Text appText(
  str, {
  TextStyle? textStyle,
  fontName,
  fontSize,
  color,
  fontWeight,
  textAlign,
  overflow,
}) {
  return Text(
    str,
    textAlign: textAlign ?? TextAlign.left,
    overflow: overflow ?? TextOverflow.visible,
    style: textStyle ??
        GoogleFonts.alata(
          fontSize: fontSize != null ? fontSize.toDouble() : 14,
          color: color ?? AppColors.whiteColor,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
  );
}

String checkValueNullOrEmpty(String? value) {
  if (value == null || value == "" || value == "null") {
    return "Not Available";
  } else {
    return value;
  }
}

String convertDateYYYYMMDDToHumanReadableFormat(String date) {
  if (date == "null" || date.isEmpty) return "";
  return Jiffy.parse(date.toString()).format(pattern: 'MMM dd yyyy hh:mm a ');
}

Widget loadingWidget({Color? color}) {
  return Center(
    child: CircularProgressIndicator(
      color: color ?? AppColors.darkBlueColor,
    ),
  );
}

Widget noDataFoundWidget({String? text}) {
  return Center(child: Text(text ?? 'No Data found'));
}

Widget errorWidget() {
  return const Center(
    child: Text(' Error Occurred'),
  );
}

getShortName(String fullName) {
  var names = fullName.split(" ");
  String firstName = names[0];
  String lastName = names[1];
  return "$firstName  $lastName";
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = AppColors.greenColor
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

SnackBar buildWebSnackBar(
  BuildContext context, {
  String message = '',
  String? title,
  SnackBarAction? snackBarAction,
}) {
  return SnackBar(
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        Text(message),
      ],
    ),
    action: snackBarAction,
    margin: EdgeInsets.only(
      left: 10,
      bottom: 10,
      right: MediaQuery.of(context).size.width - 400,
    ),
  );
}

displaySnackBar(
  BuildContext context, {
  String message = '',
  String title = "",
  Color backgroundColor = AppColors.greenColor,
  Color iconColor = AppColors.backgroundColor,
  IconData? icon = Icons.done,
}) {
  return Get.snackbar(
    "$title",
    "$message",
    colorText: AppColors.whiteColor,
    duration: Duration(seconds: 4),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    margin: EdgeInsets.all(30),
    icon: Icon(
      icon,
      color: iconColor,
    ),
  );
}
