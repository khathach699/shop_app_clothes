import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/features/shop/controllers/CartController.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Column(
      children: [
        // Sub total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal:", style: Theme.of(context).textTheme.bodyMedium),
            Obx(
              () => Text(
                "\$${controller.totalPrice.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
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
