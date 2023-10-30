import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget(
      {super.key,
 
      this.borderColor = AppColors.darkBlueColor});

  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: borderColor)),
      child: Center(
        child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            "images/arrow_back.svg",
            height: 25,
            // ignore: deprecated_member_use
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
