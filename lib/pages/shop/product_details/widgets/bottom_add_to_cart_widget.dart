import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/pages/controllers/ProductController.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

import '../../../models/CartRequest.dart';
import '../../checkout/checkout.dart';
import '../../../service/CartService.dart'; // Import CartService

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
                'Giỏ hàng thành công', // Tiêu đề
                'Sản phẩm đã được thêm vào giỏ hàng.',
                snackPosition: SnackPosition.TOP, // Vị trí thông báo
                backgroundColor: Colors.green, // Màu nền
                colorText: Colors.white, // Màu chữ
                duration: Duration(seconds: 2), // Thời gian hiển thị
              );
              final box = GetStorage();

              // Read the cart items and cast them safely
              List<Map<String, dynamic>> cartItems = [];
              var storedItems = box.read('cartItems');

              // Check if the cart is already stored
              if (storedItems != null) {
                // Ensure the stored data is of the correct type
                cartItems = List<Map<String, dynamic>>.from(storedItems);
              }

              // Check if the product already exists in the cart
              bool productExists = false;
              for (var item in cartItems) {
                if (item['productId'] == productId) {
                  // If the product exists, update the quantity
                  item['quantity'] +=
                      quantity; // You can also set this to the desired quantity if you want to overwrite
                  productExists = true;
                  break;
                }
              }

              // If the product does not exist, add it to the cart
              if (!productExists) {
                cartItems.add({
                  "productId": productId,
                  "quantity": quantity,
                  "colorId": selectedColorId,
                  "sizeId": selectedSizeId,
                });
              }

              // Store the updated cart back to GetStorage
              await box.write('cartItems', cartItems);

              // Debug print to check cartItems after updating

              // Optionally, show a confirmation or update the UI
            },
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSize.md),
              backgroundColor: Colors.blue,
              side: BorderSide(color: TColors.black),
            ),
            child: Text("Thanh toán"),
            onPressed: () async {
              // Kiểm tra xem người dùng đã chọn color và size hay chưa
              int selectedColorId = productController.getSelectedColorId();
              int selectedSizeId = productController.getSelectedSizeId();
              int quantity = productController.quantity.value;

              if (selectedColorId == 0 || selectedSizeId == 0) {
                // Thông báo lỗi nếu thiếu thông tin
                Get.snackbar(
                  'Thiếu thông tin', // Tiêu đề
                  'Vui lòng chọn màu sắc và kích thước trước khi thanh toán.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                );
                return;
              }

              // Thông báo thành công và chuyển hướng sang màn hình thanh toán
              Get.snackbar(
                'Đang chuyển hướng', // Tiêu đề
                'Bạn đang được chuyển sang thanh toán.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.blue,
                colorText: Colors.white,
                duration: Duration(seconds: 2),
              );

              // Pass data to checkout screen
              Get.to(
                () => TCheckOut(),
                arguments: {
                  'productId': productId,
                  'selectedColorId': selectedColorId,
                  'selectedSizeId': selectedSizeId,
                  'quantity': quantity,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
