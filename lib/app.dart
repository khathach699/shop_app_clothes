import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/auth/login/login.dart';
import 'package:shop_app_clothes/utils/constants/pagePath.dart';
import 'package:shop_app_clothes/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      getPages: pagePath,
      theme: TApptheme.lightTheme,
      darkTheme: TApptheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
