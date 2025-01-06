import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:shop_app_clothes/common/widgets/images/t_roundted_image.dart';
import 'package:shop_app_clothes/features/shop/controllers/home_controller.dart';
import 'package:shop_app_clothes/features/shop/screens/product_details/product_detail.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../../models/Product.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key, required this.banner, required this.products});
  final List<String> banner;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          items:
              banner.map((url) {
                int index = banner.indexOf(url);
                return GestureDetector(
                  onTap: () {
                    // Get the product associated with this banner image
                    Product selectedProduct = products[index];
                    Get.to(() => ProductDetail(product: selectedProduct));
                  },
                  child: TRoundedImage(imageUrl: url),
                );
              }).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enlargeCenterPage: true,
            scrollPhysics: BouncingScrollPhysics(),
          ),
        ),
        const SizedBox(height: TSize.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banner.length; i++)
                  TCircularContainer(
                    width: 20,
                    height: 4,
                    margin: EdgeInsets.only(right: 10),
                    backgroundColor:
                        controller.carouselCurrentIndex.value == i
                            ? TColors.primaryColor
                            : TColors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
