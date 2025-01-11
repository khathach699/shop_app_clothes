import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/features/shop/models/Cart.dart';
import 'package:shop_app_clothes/features/shop/service/CartService.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs; // Observable list of cart items
  final isLoading = true.obs; // Observable loading state
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  // Fetch cart items from backend
  Future<void> fetchCartItems() async {
    final userId = box.read('userId');
    if (userId != null) {
      try {
        final items = await CartService().getCart(userId);
        cartItems.assignAll(items ?? []);
      } catch (e) {
        print('Error fetching cart: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
    }
  }

  // Remove cart item
  Future<void> removeCartItem(int cartId) async {
    final success = await CartService().removeFromCart(cartId);
    if (success) {
      cartItems.removeWhere((item) => item.cartId == cartId);
      Get.snackbar(
        'Item removed!',
        'Your item has been successfully removed from the cart.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to remove the item from the cart.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // Calculate total quantity
  int get totalQuantity =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Calculate total price
  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + (item.quantity * item.price));
}
