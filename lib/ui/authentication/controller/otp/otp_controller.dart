import 'package:get/get.dart';
import 'package:real_estate_app/data/repositories/authentication/authentication_repository.dart';
import 'package:real_estate_app/ui/screens/home/HomeScreen.dart';

import '../../../../utils/popups/loaders.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final isLoading = false.obs;
  final otpCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data or state here
  }

  void setOtpCode(String code) {
    otpCode.value = code;
  }

  Future<void> verifyOtp(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOtp(otp);
    isVerified?.user != null ? Get.offAll(const HomeScreen()) : Get.back();
    /*if (otpCode.value.isEmpty) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Please enter the OTP code.');
      return;
    }

    try {
      isLoading.value = true;
      // Simulate network call for OTP verification
      await Future.delayed(const Duration(seconds: 2));

      // Here you would typically call your API to verify the OTP
      // For now, we will just simulate a successful verification
      TLoaders.successSnackBar(title: 'Success', message: 'OTP verified successfully!');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }*/
  }
}