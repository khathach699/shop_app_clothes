import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/pages/controllers/ProductController.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/pages/controllers/CartController.dart';

class TBottomAddToCartWidget extends StatelessWidget {
  final int productId;
  final String productImage;
  final double price;

  const TBottomAddToCartWidget({
    super.key,
    required this.productId,
    required this.productImage,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final cartController = Get.find<CartController>();

    final darkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSize.defaultSpace,
        vertical: TSize.spaceBtwItems,
      ),
      decoration: BoxDecoration(
        color: darkMode ? Colors.black : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSize.cardRadiusLg),
          topRight: Radius.circular(TSize.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuantityController(productController),
          _buildAddToCartButton(productController, cartController),
          _buildCheckoutButton(productController),
        ],
      ),
    );
  }

  Widget _buildQuantityController(ProductController controller) {
    return Row(
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          backgroundColor: TColors.grey,
          width: 40,
          height: 40,
          onPressed: controller.decrementQuantity,
        ),
        const SizedBox(width: TSize.spaceBtwItems),
        Obx(
          () => Text(
            "${controller.quantity.value}",
            style: Get.textTheme.titleSmall,
          ),
        ),
        const SizedBox(width: TSize.spaceBtwItems),
        TCircularIcon(
          icon: Iconsax.add,
          backgroundColor: TColors.grey,
          width: 40,
          height: 40,
          color: Colors.white,
          onPressed: controller.incrementQuantity,
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(
    ProductController productController,
    CartController cartController,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(TSize.md),
        backgroundColor: TColors.black,
        side: BorderSide(color: TColors.black),
      ),
      child: const Text("Add to Cart"),
      onPressed: () {
        cartController.addToCart(productController, productId);
      },
    );
  }

  Widget _buildCheckoutButton(ProductController controller) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(TSize.md),
        backgroundColor: Colors.blue,
        side: BorderSide(color: TColors.black),
      ),
      child: const Text("Thanh toán"),
      onPressed: () {
        controller.checkout(productId);
      },
    );
  }
}
