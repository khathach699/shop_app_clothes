import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/pages/auth/Widget/text_field.dart';
import 'package:shop_app_clothes/pages/controllers/SignUpController.dart';

import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/constants/text_strings.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TSize.defaultSpace,
            vertical: TSize.spaceBtwSections,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Your Account",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: TSize.spaceBtwSections),

              // Username Field
              CustomTextField(
                controller: controller.usernameController,
                labelText: TText.userName,
                prefixIcon: Iconsax.user,
                obscureText: false,
              ),
              const SizedBox(height: TSize.spaceBtwInputField),

              // Email Field
              CustomTextField(
                controller: controller.emailController,
                labelText: TText.email,
                prefixIcon: Iconsax.direct_right,
                obscureText: false,
              ),
              const SizedBox(height: TSize.spaceBtwInputField),

              // Password Field
              CustomTextField(
                controller: controller.passwordController,
                labelText: TText.password,
                prefixIcon: Iconsax.password_check,
                suffixIcon: const Icon(Iconsax.eye_slash),
                obscureText: true,
              ),
              const SizedBox(height: TSize.spaceBtwSections),

              // Nút Sign Up
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        controller.isLoading.value ? null : controller.signUp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              TText.signUp,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
              ),

              // Hiển thị lỗi nếu có
              Obx(
                () =>
                    controller.errorMessage.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.only(
                            top: TSize.spaceBtwItems,
                          ),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                        : const SizedBox.shrink(),
              ),

              // Link đến Login
              const SizedBox(height: TSize.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.offNamed("/signIn");
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.grey[600]),
                      children: const [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
