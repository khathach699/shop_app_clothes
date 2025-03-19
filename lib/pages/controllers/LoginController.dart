// login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/pages/service/AuthService.dart';
import 'package:shop_app_clothes/navigation_menu.dart';

class LoginController extends GetxController {
  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  final rememberMe = false.obs;
  final errorMessage = ''.obs;

  // Services
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    try {
      final savedUsername = await _secureStorage.read(key: 'username');
      final savedPassword = await _secureStorage.read(key: 'password');

      if (savedUsername != null && savedPassword != null) {
        usernameController.text = savedUsername;
        passwordController.text = savedPassword;
        rememberMe.value = true;
      }
    } catch (e) {
      errorMessage.value = 'Error loading saved credentials';
    }
  }

  Future<void> login() async {
    // Validate inputs
    if (usernameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter both email and password';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final user = await _authService.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      // Save user ID
      await _storage.write('userId', user.id);

      // Handle remember me
      if (rememberMe.value) {
        await _secureStorage.write(
          key: 'username',
          value: usernameController.text.trim(),
        );
        await _secureStorage.write(
          key: 'password',
          value: passwordController.text.trim(),
        );
      } else {
        await _secureStorage.delete(key: 'username');
        await _secureStorage.delete(key: 'password');
      }

      // Navigate to main screen
      Get.offAllNamed("/homePage");
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
