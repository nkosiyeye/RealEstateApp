import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_app/ui/authentication/controller/otp/otp_controller.dart';

import '../../../../utils/constants/sizes.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otp;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter code sent to your Number"
                , style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 28)
            ),
            Text("we sent it the number +91 987 654 3210", style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: 40,),
            const Text("Enter the 6-digit code sent to your phone number",
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20,),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              textStyle: const TextStyle(fontSize: 20, color: Colors.black),
              onCodeChanged: (String code) {
                // Handle the code change
              },
              onSubmit: (String verificationCode) {
                otp = verificationCode;
                OTPController.instance.verifyOtp(otp);
                // Handle the OTP submission
                //print("OTP Submitted: $verificationCode");
              },
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  var controller = Get.put(OTPController());
                  // Handle OTP verification
                  controller.verifyOtp(otp);
                },
                child: const Text("Verify OTP")
              ),
            ),
          ],
        ),
      ),

    );
  }
}
