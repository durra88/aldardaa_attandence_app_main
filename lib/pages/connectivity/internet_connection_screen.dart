import 'package:attendance_app/helper/app_colors/app_colors.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckInternetWidget extends StatelessWidget {
  const CheckInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // appBar: AppBar(
      //   backgroundColor: AppColors.darkBlueColor,
      // ),
      body: Container(
        alignment: Alignment.center,
        // padding: const EdgeInsets.only(top: 50),
        child: Container(
          height: screenHeight(context),
          child: Center(
            child: Lottie.asset('images/lotties/internet.json',
                width: 300, height: 240),
          ),

          //  Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: <Widget>[
          //   // Container(
          //   // padding: EdgeInsets.only(top: 10), child: CloseButton()),

          //   const SizedBox(
          //     height: 30.0,
          //   ),
          // ]),
        ),
      ),
    );
  }
}
