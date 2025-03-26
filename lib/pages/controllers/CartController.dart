import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/pages/models/Cart.dart';
import 'package:shop_app_clothes/pages/service/CartService.dart';
import '../models/CartRequest.dart';
import '../service/StorageService.dart';
import 'ProductController.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;
  final isLoading = true.obs;
  int? userId;

  @override
  void onInit() async {
    super.onInit();
    await _loadUserId();
    await fetchCartItems();
  }

  Future<void> _loadUserId() async {
    userId = await StorageService.getUserId();
    update();
  }

  Future<void> fetchCartItems() async {
    if (userId == null) return;
    try {
      isLoading.value = true;
      final items = await CartService().getCart(userId!);
      cartItems.assignAll(items ?? []);
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải giỏ hàng.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(ProductController productController, int productId) async {
    if (userId == null) {
      Get.snackbar("Lỗi", "Bạn cần đăng nhập trước khi thêm sản phẩm vào giỏ.");
      return;
    }
    if(productController.getSelectedColorId() == 0 ||productController.getSelectedSizeId() == 0){

      Get.snackbar("Lỗi", "Bạn cần chọn màu và size trước khi thêm sản phẩm vào giỏ.",
      snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.black,
      );
    }

    final request = CartRequest(
      userId: userId!,
      productId: productId,
      colorId: productController.getSelectedColorId(),
      sizeId: productController.getSelectedSizeId(),
      quantity: productController.quantity.value,
    );

    final success = await CartService().addToCart(request);
    if (success != null) {
      Get.snackbar(
        'Giỏ hàng',
        'Sản phẩm đã được thêm vào giỏ.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await fetchCartItems();
    }
  }

  Future<void> removeCartItem(int cartId) async {
    final success = await CartService().removeFromCart(cartId);
    if (success) {
      cartItems.removeWhere((item) => item.cartId == cartId);
      Get.snackbar(
        'Xóa sản phẩm',
        'Sản phẩm đã được xóa khỏi giỏ hàng.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.lightGreen,
        colorText: Colors.white,
      );
    }
  }

  int get totalQuantity => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + (item.quantity * item.price));
}
