import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/pages/controllers/home_controller.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';
import 'package:shop_app_clothes/pages/shop/all_products/all_products.dart';
import 'package:shop_app_clothes/pages/shop/home/widgets/promo_slider.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class ProductContent extends StatelessWidget {
  final List<Product> products;

  const ProductContent({required this.products});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      children: [
        TPromoSlider(banner: controller.getBannerImages(), products: products),
        const SizedBox(height: TSize.spaceBtwItems),
        TSectionHeading(
          title: "New Arrivals",
          buttonTitle: "View All",
          onPressed: () => Get.to(() => const AllProducts()),
        ),
        const SizedBox(height: TSize.spaceBtwItems / 2),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder:
              (_, index) => TProductCardVertical(product: products[index]),
        ),
      ],
    );
  }
}
