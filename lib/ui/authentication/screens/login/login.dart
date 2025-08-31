import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/authentication/screens/login/widgets/login_form.dart';
import 'package:real_estate_app/ui/authentication/screens/login/widgets/login_header.dart';

import '../../../../common/style/spacing_syles.dart';
import '../../../../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title, & Sub-Title
              LoginHeader(),

              ///Form
              LoginForm(),

              /// Divider
              //TFormDivider(dividerText: TTexts.orSignInWith,),
              SizedBox(height: TSizes.spaceBtwSections,),
              /// Footer
              //TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}








