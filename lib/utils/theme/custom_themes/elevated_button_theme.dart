import 'package:flutter/material.dart';

// Lớp TElevateButtonTheme dùng để định nghĩa các kiểu theme cho ElevatedButton (nút bấm nổi)
// trong ứng dụng Flutter, giúp tạo giao diện đồng nhất cho chế độ sáng (light) và tối (dark).
class TElevateButtonTheme {
  TElevateButtonTheme._();
  // Constructor private (_): Không cho phép tạo đối tượng từ lớp này.
  // Lớp chỉ được sử dụng để chứa các thuộc tính và phương thức tĩnh (static).

  // Theme cho ElevatedButton ở chế độ sáng (light theme)
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0, // Độ cao của nút (0 nghĩa là không có bóng).
      foregroundColor: Colors.white, // Màu chữ trên nút khi hoạt động.
      backgroundColor: Colors.blue, // Màu nền nút khi hoạt động.
      disabledForegroundColor: Colors.grey, // Màu chữ khi nút bị vô hiệu hóa.
      disabledBackgroundColor: Colors.grey, // Màu nền nút khi bị vô hiệu hóa.
      side: const BorderSide(
        color: Colors.blue,
      ), // Viền xung quanh nút (màu xanh).
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
      ), // Khoảng cách trên-dưới của nội dung trong nút.
      textStyle: const TextStyle(
        fontSize: 16.0, // Kích thước chữ trong nút.
        color:
            Colors
                .white, // Màu chữ (thực tế được override bởi foregroundColor).
        fontWeight: FontWeight.w600, // Độ đậm của chữ.
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ), // Bo tròn viền nút (812: bo tròn hoàn toàn, tạo hình oval).
      ),
    ),
  );

  // Theme cho ElevatedButton ở chế độ tối (dark theme)
  static final darkElevateButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0, // Độ cao của nút (không có bóng).
      foregroundColor: Colors.white, // Màu chữ trên nút khi hoạt động.
      backgroundColor: Colors.blue, // Màu nền nút khi hoạt động.
      disabledForegroundColor: Colors.grey, // Màu chữ khi nút bị vô hiệu hóa.
      disabledBackgroundColor: Colors.grey, // Màu nền nút khi bị vô hiệu hóa.
      side: const BorderSide(
        color: Colors.blue,
      ), // Viền xung quanh nút (màu xanh).
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
      ), // Khoảng cách trên-dưới của nội dung trong nút.
      textStyle: const TextStyle(
        fontSize: 16.0, // Kích thước chữ trong nút.
        color:
            Colors
                .white, // Màu chữ (thực tế được override bởi foregroundColor).
        fontWeight: FontWeight.w600, // Độ đậm của chữ.
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ), // Bo tròn viền nút (hình oval).
      ),
    ),
  );
}
