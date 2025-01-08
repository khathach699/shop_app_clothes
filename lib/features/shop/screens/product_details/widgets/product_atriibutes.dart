import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/chips/choice_chip.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/controllers/ProductController.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../../models/Product.dart';
class TProductAttributes extends StatelessWidget {
  final Product product;

  const TProductAttributes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return Column(
      children: [
        // Colors section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: "Colors", showActionButton: false),
            const SizedBox(height: TSize.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: product.colorSizes.map((colorSize) {
                return Obx(() {
                  return TChoiceChip(
                    text: colorSize.colorName,
                    selected: productController.selectedColor.value == colorSize.colorName,
                    onSelected: (value) {
                      if (value) {
                        productController.setSelectedColor(colorSize.colorName);
                      }
                    },
                  );
                });
              }).toList(),
            ),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems),

        // Size section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: "Size", showActionButton: false),
            SizedBox(height: TSize.spaceBtwItems / 2),
            Wrap(
              spacing: 12,
              children: product.colorSizes.map((colorSize) {
                return Obx(() {
                  return TChoiceChip(
                    text: colorSize.sizeName,
                    selected: productController.selectedSize.value == colorSize.sizeName,
                    onSelected: (value) {
                      if (value) {
                        productController.setSelectedSize(colorSize.sizeName);
                      }
                    },
                  );
                });
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
