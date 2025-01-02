import 'package:flutter/material.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/appbar_theme.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/chip_theme.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/outlined_butto_theme.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/text_filed_theme.dart';
import 'package:shop_app_clothes/utils/theme/custom_themes/text_theme.dart';

class TApptheme {
  TApptheme._(); // Không cho phép tạo đối tượng từ lớp TApptheme. Lớp này chỉ dùng để chứa các thuộc tính và phương thức tĩnh (static).
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextThem,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBartheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomTheme,
    elevatedButtonTheme: TElevateButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonThemeData,
    inputDecorationTheme: TTextFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevateButtonTheme.darkElevateButtonTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBartheme.dartAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.dartBottomTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonThemeData,
    inputDecorationTheme: TTextFieldTheme.darkInputDecorationTheme,
  );
}
