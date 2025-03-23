// t_login_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/pages/controllers/LoginController.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSize.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TText.email,
              ),
            ),
            const SizedBox(height: TSize.spaceBtwInputField),
            TextFormField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TText.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
              obscureText: true,
            ),
            const SizedBox(height: TSize.spaceBtwInputField / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: controller.toggleRememberMe,
                      ),
                      const Text(TText.rememberMe),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(TText.forgotPassword),
                ),
              ],
            ),

            const SizedBox(height: TSize.spaceBtwSections),

            // Sign In Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.login,
                  child:
                      controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text(TText.signIn),
                ),
              ),
            ),
            const SizedBox(height: TSize.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to("/signUp");
                },
                child: const Text(TText.signUp),
              ),
            ),

            // Error Message
            Obx(
              () =>
                  controller.errorMessage.isNotEmpty
                      ? Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          controller.errorMessage.value,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
