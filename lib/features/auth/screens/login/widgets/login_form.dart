import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/constants/text_strings.dart';

import '../../../../shop/models/User.dart';
import '../../../../shop/service/AuthService.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false; // Tracks "Remember Me" checkbox state
  String _errorMessage = '';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    // Load saved username and password if "Remember Me" was selected
    String? savedUsername = await _secureStorage.read(key: 'username');
    String? savedPassword = await _secureStorage.read(key: 'password');

    if (savedUsername != null && savedPassword != null) {
      setState(() {
        _usernameController.text = savedUsername;
        _passwordController.text = savedPassword;
        _rememberMe = true; // Set checkbox state
      });
    }
  }

  Future<void> login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Reset error message
    });

    AuthService authService = AuthService();

    try {
      // Call API for login from AuthService
      User response = await authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (response.message == "Login successful") {
        // Fetch user information
        String usernameOrEmail = _usernameController.text;
        User user = await authService.getUserInfoByUsernameOrEmail(
          usernameOrEmail,
        );

        // Save userId to GetStorage
        final box = GetStorage();
        box.write('userId', user.id!); // Assuming `user.id` is not null

        // Save username/email and password to secure storage if "Remember Me" is checked
        if (_rememberMe) {
          await _secureStorage.write(
            key: 'username',
            value: _usernameController.text,
          );
          await _secureStorage.write(
            key: 'password',
            value: _passwordController.text,
          );
        } else {
          await _secureStorage.delete(key: 'username');
          await _secureStorage.delete(key: 'password');
        }

        // Navigate to the next page
        Get.offAll(() => const NavigationMenu());
      } else {
        setState(() {
          _errorMessage = response.message ?? "Login failed";
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSize.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TText.email,
              ),
            ),
            const SizedBox(height: TSize.spaceBtwInputField),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TText.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
              obscureText: true,
            ),
            const SizedBox(height: TSize.spaceBtwInputField / 2),

            // Remember Me and Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    const Text(TText.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(TText.forgotPassword),
                ),
              ],
            ),

            const SizedBox(height: TSize.spaceBtwSections),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : login,
                child:
                    _isLoading
                        ? const CircularProgressIndicator() // Show loading when logging in
                        : Text(TText.signIn),
              ),
            ),
            const SizedBox(height: TSize.spaceBtwItems),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(TText.signUp),
              ),
            ),

            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
