import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/features/shop/controllers/CartController.dart';
import 'package:shop_app_clothes/features/shop/controllers/ProductController.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final ProductController productController = Get.find<ProductController>();

    return Column(
      children: [
        // Sub total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal:", style: Theme.of(context).textTheme.bodyMedium),
            Obx(() {
              // Kiểm tra nếu có giá trị từ CartController, thì hiển thị nó
              if (cartController.totalPrice >= 0) {
                return Text(
                  "\$${cartController.totalPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              } else if (productController.totalPrice > 0) {
                // Nếu không có giá trị từ CartController, hiển thị giá trị từ ProductController
                return Text(
                  "\$${productController.totalPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              } else {
                // Nếu cả hai đều không có giá trị, hiển thị mặc định
                return Text(
                  "\$0.00",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              }
            }),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping:", style: Theme.of(context).textTheme.bodyMedium),
            Text("Free", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
