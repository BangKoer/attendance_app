import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotpasswordController extends GetxController {
  //TODO: Implement LoginController
  final emailController = TextEditingController();
  final passController1 = TextEditingController();
  final passController2 = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passController1.dispose();
    passController2.dispose();
    super.onClose();
  }
}
