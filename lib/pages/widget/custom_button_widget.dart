import 'package:flutter/material.dart';
import 'package:attendance_app/controller/animation_controller.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

class AnimatedLogInButton extends StatelessWidget {
  const AnimatedLogInButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.buttonColor = AppColors.darkBlueColor,
    this.titleColor = AppColors.whiteColor,
    this.borderRadius,
    this.heightButton = 50,
    this.widthButton = 300,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final Color buttonColor;
  final Color titleColor;
  final double widthButton, heightButton;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      scaleFactor: 1.0,
      onPressed: () {
        onTap();
      },
      child: Container(
        width: widthButton,
        height: heightButton,
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  buttonColor.withOpacity(1),
                  buttonColor,
                ]),
            boxShadow: const [
              BoxShadow(
                color: AppColors.whiteColor,
                blurRadius: 15.0,
                offset: Offset(0.0, 4.0),
                spreadRadius: 4.0,
              )
            ]),
        child: Center(
          child: appText(
            "${title}",
            color: titleColor,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}
