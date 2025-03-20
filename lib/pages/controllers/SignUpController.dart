import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shop_app_clothes/pages/service/UserService.dart';

class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = "".obs;

  final UserService _userService = UserService();

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      errorMessage.value = "Please fill in all fields";
      return;
    }

    isLoading.value = true;
    errorMessage.value = "";

    try {
      final user = await _userService.createUser(
        usernameController.text.trim(),
        passwordController.text.trim(),
        emailController.text.trim(),
      );

      _clearTextFields();
      Get.offAllNamed("/signIn");
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void _clearTextFields() {
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
  }
}
