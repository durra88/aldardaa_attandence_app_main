import 'dart:developer';

import 'package:attendance_app/firebase/attendance_firebase.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class AttendanceController extends GetxController {
  var userModelList = <UserModel>[].obs;

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  String emailRegex =
      r'''[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'+/=?^_`{|}~-]+)@(?:[a-z0-9](?:[a-z0-9-][a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?''';

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  fetchUsers() async {
    await AttendanceFirebase().fetchUserModel().then((value) {
      userModelList.value = value;
      log("menux length get Data= ${userModelList.length}");
    });
  }

  updateUser({required UserModel userModel}) {
    AttendanceFirebase().updateUser(userModel: userModel);
    log("the help menu menux 5from db: ${userModel.embeddings}");
  }

  addNewUser({required UserModel userModel}) {
    AttendanceFirebase().addUser(userModel: userModel);
    log("menux length get Data= ${userModelList.length}");

    //log("the help menu menux 5from db: $userModel");
  }
}
