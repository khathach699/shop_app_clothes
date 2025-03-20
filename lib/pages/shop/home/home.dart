// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/primary_header_primary.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/search_container.dart';
import 'package:shop_app_clothes/pages/controllers/home_controller.dart';
import 'package:shop_app_clothes/pages/shop/home/widgets/home_appbar.dart';
import 'package:shop_app_clothes/pages/shop/home/widgets/home_categories_section.dart';
import 'package:shop_app_clothes/pages/shop/home/widgets/product_content.dart';
import 'package:shop_app_clothes/pages/shop/home/widgets/shimmer_loading.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo controller
    final controller = Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  SizedBox(height: TSize.spaceBtwSections / 2),
                  TSearchContainer(
                    text: "Search in store",
                    padding: EdgeInsets.all(TSize.sm),
                  ),
                  SizedBox(height: TSize.spaceBtwSections / 2),
                  HomeCategoriesSection(),
                  SizedBox(height: TSize.spaceBtwSections / 2),
                ],
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(TSize.defaultSpace),
              child: Obx(
                () =>
                    controller.isLoading.value
                        ? const ShimmerLoading()
                        : controller.errorMessage.isNotEmpty
                        ? ErrorWidget(controller.errorMessage.value)
                        : ProductContent(products: controller.products),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
