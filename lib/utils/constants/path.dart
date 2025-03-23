import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/pages/auth/login/login.dart';
import 'package:shop_app_clothes/pages/auth/signup/sign_up_page.dart';

var Path = [
  GetPage(name: "/homePage", page: () => NavigationMenu()),
  GetPage(name: "/homePage", page: () => NavigationMenu()),
  GetPage(name: "/signUp", page: () => SignUpPage()),
  GetPage(name: "/signIn", page: () => LoginScreen()),
];
