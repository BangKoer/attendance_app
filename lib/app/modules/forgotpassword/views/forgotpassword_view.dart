import 'package:attendance_app/app/modules/login/components/customtextfield.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgotpassword_controller.dart';

class ForgotpasswordView extends GetView<ForgotpasswordController> {
  const ForgotpasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Ubah Password'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              17.0,
              MediaQuery.of(context).padding.top + 40.0,
              17.0,
              12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Image.asset(
                  'assets/password.png',
                  scale: 2.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  'Halo Calvin!\nUbah Password dulu, yuk!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Text(
                  'Biar akunmu tetap aman,\nubah passwordmu dulu ya!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                // password field
                CustomPasswordField(
                    controllerfield: controller.passController1,
                    label: 'Password Lama'),
                SizedBox(
                  height: 24,
                ),
                // password field
                CustomPasswordField(
                    controllerfield: controller.passController2,
                    label: 'Password Baru'),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.FORGOTPASSWORD);
                      },
                      child: Text('Lupa Password'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
