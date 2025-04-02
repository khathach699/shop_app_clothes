import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/app.dart';
import 'package:shop_app_clothes/pages/controllers/CartController.dart';
import 'package:shop_app_clothes/pages/controllers/ProductController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(CartController());
  Get.put(ProductController());
  runApp(const App());
}
