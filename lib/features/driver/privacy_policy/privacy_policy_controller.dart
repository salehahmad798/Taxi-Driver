import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  var isLoading = false.obs;
  var privacyPolicyText = RxnString();
  var error = RxnString();

  Future<void> fetchPrivacyPolicy() async {
    isLoading.value = true;
    error.value = null;

    try {
      // Simulate network call
      await Future.delayed(const Duration(seconds: 2));
      // Replace with actual fetch logic
      privacyPolicyText.value = "Your privacy policy goes here.";
    } catch (e) {
      error.value = "Failed to load privacy policy.";
    } finally {
      isLoading.value = false;
    }
  }
}
