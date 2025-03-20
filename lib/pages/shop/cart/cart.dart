import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/controllers/CartController.dart';
import 'package:shop_app_clothes/pages/shop/checkout/checkout.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import '../../../common/widgets/products/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.cartItems.isEmpty) {
          return Center(child: Text("Your cart is empty"));
        }
        return Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: ListView.builder(
            itemCount: controller.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = controller.cartItems[index];
              return TCartItem(
                cartId: cartItem.cartId,
                productName: cartItem.productName,
                colorName: cartItem.colorName,
                sizeName: cartItem.sizeName,
                quantity: cartItem.quantity.toString(),
                price: cartItem.price,
                productImage: cartItem.productImage ?? '',
                onRemove: () => controller.removeCartItem(cartItem.cartId),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSize.defaultSpace),
        child: Obx(
          () => ElevatedButton(
            onPressed:
                controller.cartItems.isEmpty
                    ? null
                    : () {
                      Get.to(
                        () => TCheckOut(),
                        arguments: {'cartItems': controller.cartItems},
                      );
                    },
            child: Text(
              "CheckOut (${controller.totalQuantity} items) \$${controller.totalPrice.toStringAsFixed(2)}",
            ),
          ),
        ),
      ),
    );
  }
}
