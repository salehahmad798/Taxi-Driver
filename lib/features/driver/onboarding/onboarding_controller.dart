import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver/routes/app_routes.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;

  List<String> images = [
    'assets/app_images/onboarding-icon1.png',
    'assets/app_images/onboarding-icon2.png',
    'assets/app_images/onboarding-icon3.png',
  ];

  List<String> title = ["Register Vehicle", "Upload Documents", "Earn Money"];
  List<String> subtext = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ];

  @override
  void onInit() {
    pageController = PageController(); 
    super.onInit();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void goToSignup() {
    Get.offAllNamed(AppRoutes.allowLocation);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
