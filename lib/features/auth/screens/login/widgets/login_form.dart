import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/constants/text_strings.dart';
import '../../../../shop/models/LoginResponse.dart';
import '../../../../shop/screens/service/AuthService.dart';


class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Reset error message
    });

    AuthService authService = AuthService();

    try {
      // Gọi API đăng nhập từ AuthService
      LoginResponse response = await authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (response.message == "Login successful") {
        // Nếu đăng nhập thành công
       // In ra thông báo để kiểm tra
        Get.offAll(() => const NavigationMenu()); // Điều hướng đến trang tiếp theo
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

            // remember me and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
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

            // sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : login,
                child: _isLoading
                    ? const CircularProgressIndicator() // Hiển thị loading khi đang đăng nhập
                    : Text(TText.signIn),
              ),
            ),
            const SizedBox(height: TSize.spaceBtwItems),
            // sign up button
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
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
