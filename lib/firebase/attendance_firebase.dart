import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert' as html;
import 'dart:convert';
import 'package:attendance_app/model/user_model.dart';

class AttendanceFirebase {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Future<List<UserModel>> fetchUserModel() async {
    var list = List<UserModel>.empty(growable: true);
    try {
      var source = await ref.child("users").once();
      var values = source.snapshot;

      UserModel userModel;
      for (var element in values.children) {
        userModel =
            UserModel.fromJson(jsonDecode(html.jsonEncode(element.value)));
        userModel.key = element.key;

        list.add(userModel);
        log("vox menux list = $list");
      }
    } catch (e) {
      print("menux ddd error $e");
      log("vox menux error = $e");
    }
    return list;
  }

  void updateUser({required UserModel userModel}) {
    try {
      ref.child("users/${userModel.key}").update(userModel.toJson());
    } catch (e) {
      log("vox menux error send data = $e");
    }
  }

  void addUser({required UserModel userModel}) {
    var newObjectKey = ref.push().key;

    try {
      ref.child("users/$newObjectKey").set(userModel.toJson());

      log("vox menux data passed = ${userModel.toJson()}");
    } catch (e) {
      log("vox menux error send data = $e");
    }
  }
}
