import 'package:attendance_app/app/modules/onboarding/views/intro_page_view.dart';
import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 20),
        child: GetBuilder(
          init: controller,
          builder: (controller) => ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                if (controller.onLastPage.value) {
                  Get.offAllNamed(Routes.LOGIN);
                } else {
                  controller.pgController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              child: Obx(() => Text(
                    controller.onLastPage.value
                        ? "Login Sekarang"
                        : "Berikutnya",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller.pgController,
            onPageChanged: (currentPage) {
              controller.onLastPage.value = (currentPage == 1);
            },
            children: [
              IntroPageView('assets/intro1.png', 'Selamat Datang, Sob!',
                  'Presensi makin sat-set-sat-set dengan sekali scan aja!'),
              IntroPageView('assets/intro2.png', 'Presensi Harian\nTanpa Cemas',
                  'Ada pengingat harian buat kamu yang sering lupa absen!'),
            ],
          ),
          // indicators
          Container(
            alignment: Alignment(0, 0.38),
            child: // dot indicator
                SmoothPageIndicator(
              controller: controller.pgController,
              count: 2,
              effect: SlideEffect(
                activeDotColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
