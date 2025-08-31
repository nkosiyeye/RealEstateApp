import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.spaceBtwSections),
              child: Column(
                children: [
                  /// Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: (value) => TValidator.validateEmail(value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: TTexts.email),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),

                  /// Password
                  Obx(
                        () => TextFormField(
                      controller: controller.verifyPassword,
                      validator: (value) => TValidator.validateEmptyText('Password',value),
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                          labelText: TTexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields / 2,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// Sign In Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>  controller.reAuthenticateEmailAndPasswordUser(),
                          child: const Text('Verify')
                      )
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
