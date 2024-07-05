import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var data;
  String baseURL = "192.168.231.100";

  var isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse(
            'http://$baseURL:8000/api/auth/login'), // Ganti dengan URL API Anda
        body: {
          'email': emailController.text,
          'password': passController.text,
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        // Simpan token atau data user jika diperlukan
        await prefs.setString('token', data['data']['token']);
        await prefs.setString('name', data['data']['user']['name']);
        await prefs.setString('email', data['data']['user']['email']);
        // Simpan status login
        await prefs.setBool('isLoggedIn', true);
        print(data);

        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar('Error', 'Login failed. Please check your credentials.');
        print(data);
      }
    } else {
      Get.snackbar('Error', 'Please enter email and password.');
    }
  }
}
