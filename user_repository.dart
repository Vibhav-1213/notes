import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:notes/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("notes").add(user.toJson()).whenComplete(() => Get.snackbar("Success", "Your note has been created",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.withOpacity(0.1),
    colorText: Colors.green,
    ),
    )
    .catchError((error, StackTrace){
      Get.snackbar("Error", "Something went wrong, try again",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
      );
    });
  } 
}