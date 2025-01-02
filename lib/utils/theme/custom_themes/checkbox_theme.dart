import 'package:flutter/material.dart';

class TCheckboxTheme {
  TCheckboxTheme._(); // Constructor private để ngăn tạo đối tượng từ lớp này.

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Bo góc checkbox.
    ),
    checkColor: WidgetStateProperty.resolveWith((states) {
      // Xử lý màu của dấu kiểm (check mark).
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // Màu khi checkbox bị vô hiệu hóa.
      }
      return Colors.black; // Màu mặc định.
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      // Xử lý màu nền của checkbox.
      if (states.contains(WidgetState.selected)) {
        return Colors.blue; // Màu nền khi bị vô hiệu hóa.
      }
      return Colors.transparent; // Màu nền mặc định.
    }),
  );

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Bo góc checkbox.
    ),
    checkColor: WidgetStateProperty.resolveWith((states) {
      // Xử lý màu của dấu kiểm (check mark).
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // Màu khi checkbox bị vô hiệu hóa.
      }
      return Colors.black; // Màu mặc định.
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      // Xử lý màu nền của checkbox.
      if (states.contains(WidgetState.selected)) {
        return Colors.blue; // Màu nền khi bị vô hiệu hóa.
      }
      return Colors.transparent; // Màu nền mặc định.
    }),
  );
}
