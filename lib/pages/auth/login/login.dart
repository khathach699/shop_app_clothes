import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_app_clothes/common/styles/spacing_style.dart';
import 'package:shop_app_clothes/common/widgets/login_signup/form_divider.dart';
import 'package:shop_app_clothes/common/widgets/login_signup/social_button.dart';
import 'package:shop_app_clothes/pages/auth/login/widgets/login_form.dart';
import 'package:shop_app_clothes/pages/auth/login/widgets/login_header.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TLoginHeader(),

              TLoginForm(),

              const SizedBox(height: TSize.spaceBtwSections),
              TFormDivider(dividerText: TText.orSignInWith.capitalize!),
              const SizedBox(height: TSize.spaceBtwSections),

              TSocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
