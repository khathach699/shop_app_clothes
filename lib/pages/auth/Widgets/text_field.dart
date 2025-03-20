import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        labelText: labelText,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
    );
  }
}
