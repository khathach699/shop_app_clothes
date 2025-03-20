import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/controllers/home_controller.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class ErrorWidget extends StatelessWidget {
  final String error;

  const ErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Error: $error'),
          const SizedBox(height: TSize.spaceBtwItems),
          ElevatedButton(
            onPressed: () => Get.find<HomeController>().fetchProducts(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
