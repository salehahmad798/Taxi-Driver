// ignore: file_names
import 'package:get/get.dart';
import 'FAQ_controller.dart';

class FAQBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQController>(() => FAQController());
  }
}