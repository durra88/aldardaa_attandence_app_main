import 'package:attendance_app/controller/camera_preview_controller.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendenceSummaryWidget extends StatelessWidget {
  const AttendenceSummaryWidget(
      {super.key, required this.controller, required this.user});
  final UserModel user;
  final CameraPreviewController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height(16),
        Text(
          '${user.name} ',
          textAlign: TextAlign.center,
          style: GoogleFonts.alata(
            fontWeight: FontWeight.w200,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        height(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'check in ',
              textAlign: TextAlign.center,
              style: GoogleFonts.alata(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            Text(
              '${controller.checkIn.value} ',
              textAlign: TextAlign.center,
              style: GoogleFonts.alata(
                fontWeight: FontWeight.w200,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        height(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'check out ',
              textAlign: TextAlign.center,
              style: GoogleFonts.alata(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            Text(
              '${user.checkOut}',
              textAlign: TextAlign.center,
              style: GoogleFonts.alata(
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontSize: 16,
              ),
            ),
          ],
        ),
        height(8),
      ],
    );
  }
}
