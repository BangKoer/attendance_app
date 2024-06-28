import 'package:attendance_app/app/modules/login/components/customtextfield.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return Container(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      controller.login();
                    },
              child: controller.isLoading.value
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text('Login'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        );
      }),
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
                Image.asset(
                  'assets/login.png',
                  scale: 2.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextField(controllerfield: controller.emailController),
                SizedBox(
                  height: 24,
                ),
                CustomPasswordField(
                  controllerfield: controller.passController,
                  label: 'Password',
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.FORGOTPASSWORD);
                      },
                      child: Text('Lupa Password'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
