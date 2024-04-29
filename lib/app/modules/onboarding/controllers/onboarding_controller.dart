import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController
  PageController pgController = PageController();
  RxBool onLastPage = false.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
