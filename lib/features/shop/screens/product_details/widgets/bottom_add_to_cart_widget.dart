import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

import '../../../controllers/ProductController.dart';
import '../../../models/CartRequest.dart';
import '../../checkout/checkout.dart';
import '../../service/CartService.dart'; // Import CartService

class TBottomAddToCartWidGet extends StatelessWidget {
  final int productId;
  final String productImage;
  final double price;

  const TBottomAddToCartWidGet({
    super.key,
    required this.productId,
    required this.productImage,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    final dark = THelperFunctions.isDarkMode(context);
    final box = GetStorage();
    int userId = box.read('userId') ?? 0; // Get userId from storage

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSize.defaultSpace,
        vertical: TSize.spaceBtwItems,
      ),
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSize.cardRadiusLg),
          topRight: Radius.circular(TSize.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.grey,
                width: 40,
                height: 40,
                onPressed: productController.decrementQuantity,
              ),
              const SizedBox(width: TSize.spaceBtwItems),
              Obx(() {
                return Text(
                  "${productController.quantity.value}",
                  style: Theme.of(context).textTheme.titleSmall,
                );
              }),
              const SizedBox(width: TSize.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.grey,
                width: 40,
                height: 40,
                color: Colors.white,
                onPressed: productController.incrementQuantity,
              ),
            ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSize.md),
              backgroundColor: TColors.black,
              side: BorderSide(color: TColors.black),
            ),
            child: Text("Add to Cart"),
            onPressed: () async {
              // Retrieve selected color and size from the controller
              int selectedColorId = productController.getSelectedColorId();
              int selectedSizeId = productController.getSelectedSizeId();
              int quantity = productController.quantity.value;

              // Create CartRequest with dynamic colorId and sizeId
              CartRequest cartRequest = CartRequest(
                userId: userId,
                productId: productId,
                colorId: selectedColorId, // Dynamic colorId
                sizeId: selectedSizeId, // Dynamic sizeId
                quantity: quantity,
              );

              // Add to Cart using CartService
              CartService cartService = CartService();
              await cartService.addToCart(cartRequest);

              Get.snackbar(
                'Added to Cart', // Title of the snackbar
                'Your item has been successfully added to the cart.',
                snackPosition: SnackPosition.TOP, // Position at the top
                backgroundColor: Colors.lightGreen, // More vibrant green color
                colorText: Colors.white, // White text color for better contrast
                duration: Duration(
                  seconds: 2,
                ), // Duration for which the snackbar will appear
                margin: EdgeInsets.only(
                  top: 50,
                  left: 20,
                ), // Position the snackbar to top-left
                padding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding
                borderRadius:
                    10, // Optional: Adds rounded corners for a smoother look
                snackStyle:
                    SnackStyle
                        .FLOATING, // Optional: Makes the snackbar floating
              );

              // Optionally, show a confirmation or update the UI
            },
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSize.md),
              backgroundColor: Colors.blue,
              side: BorderSide(color: TColors.black),
            ),
            child: Text("Payment"),
            onPressed: () => Get.to(() => TCheckOut()),
          ),
        ],
      ),
    );
  }
}
