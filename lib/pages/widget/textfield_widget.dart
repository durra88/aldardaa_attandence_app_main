import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      this.hintText = "",
      required this.icon,
      required this.controller,
      required this.onChange,
      this.iconColor = AppColors.lightRedColor});
  final String hintText;
  final IconData icon;
  final Color iconColor;
  final TextEditingController controller;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: screenWidth(context) * 0.9,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      child: TextFormField(
        onChanged: (value) {
          onChange(value);
        },
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              icon,
              color: iconColor,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.greyTextColor)),
      ),
    );
  }
}
