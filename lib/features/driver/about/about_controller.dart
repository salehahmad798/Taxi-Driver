import 'package:get/get.dart';

class AboutController extends GetxController {
  var aboutText = "This is the Taxi Driver app. Version 1.0.0".obs;

  void updateAboutText(String newText) {
    aboutText.value = newText;
  }
}