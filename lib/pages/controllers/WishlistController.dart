import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';
import 'package:shop_app_clothes/pages/service/WishlistService.dart';

import '../service/StorageService.dart';

class WishlistController extends GetxController {
  final WishListService _wishlistService = WishListService();

  // Observable state
  final wishlist = <Product>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isInWishlist = false.obs;
  int? userId;

  @override
  void onInit() async {
    super.onInit();
    await _loadUserId();
    await fetchWishlist();

  }

  Future<void> _loadUserId() async {
    userId = await StorageService.getUserId();
  }

  Future<void> fetchWishlist() async {
    if (userId == null) {
      errorMessage.value = 'User not logged in!';
      return;
    }
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetchedWishlist = await _wishlistService.getWishlist(userId!);
      print(fetchedWishlist);
      wishlist.assignAll(fetchedWishlist);
    } catch (e) {
      errorMessage.value = 'Failed to fetch wishlist: $e';
      wishlist.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkIfInWishlist(int productId) async {
    if (userId == null) return;
    try {
      final exists = await _wishlistService.isProductInWishlist(
        userId!,
        productId,
      );
      isInWishlist.value = exists;
    } catch (e) {
      errorMessage.value = 'Error checking wishlist: $e';
    }
  }

  Future<void> toggleWishlist(int productId) async {
    if (userId == null) {
      Get.snackbar('Error', 'Please log in to manage wishlist');
      return;
    }

    try {
      if (isInWishlist.value) {
        await _wishlistService.removeProductFromWishlist(userId!, productId);
        wishlist.removeWhere((p) => p.id == productId);
        isInWishlist.value = false;
        Get.snackbar(
          'Wishlist xóa thành công',
          'Sản phẩm đã được xóa khỏi wishlist.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        await _wishlistService.addProductToWishlist(userId!, productId);
        isInWishlist.value = true;
        Get.snackbar(
          'Wishlist thành công',
          'Sản phẩm đã được thêm vào wishlist.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      errorMessage.value = 'Error toggling wishlist: $e';
      Get.snackbar(
        'Error toggling wishlist',
        '$e.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
