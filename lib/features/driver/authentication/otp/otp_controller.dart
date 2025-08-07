import 'package:get/get.dart';

class OtpController extends GetxController {
  var otp = ''.obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();

  void updateOtp(String value) {
    otp.value = value;
  }

  Future<void> verifyOtp({
    required String phoneNumber,
    required Future<bool> Function(String otp, String phoneNumber) onVerify,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      bool isValid = await onVerify(otp.value, phoneNumber);
      if (!isValid) {
        errorMessage.value = 'Invalid OTP. Please try again.';
      }
    } catch (e) {
      errorMessage.value = 'Verification failed. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void clear() {
    otp.value = '';
    errorMessage.value = null;
  }
}
