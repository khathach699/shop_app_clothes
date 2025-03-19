import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../service/WishlistService.dart';

class WishlistController extends GetxController {
  var isInWishlist = false.obs;

  // Hàm kiểm tra sản phẩm có trong wishlist không
  Future<void> checkIfInWishlist(int userId, int productId) async {
    try {
      bool exists = await WishListService.isProductInWishlist(
        userId,
        productId,
      );
      isInWishlist.value = exists; // Chỉ cập nhật trạng thái
    } catch (e) {
      print("Error checking wishlist status: $e");
    }
  }

  // Hàm toggle wishlist khi người dùng nhấn vào nút
  toggleWishlist(int userId, int productId) async {
    try {
      if (isInWishlist.value) {
        // If the product is in the wishlist, remove it
        await WishListService.removeProductFromWishlist(userId, productId);
        Get.snackbar(
          'wishlist xóa thành công', // Tiêu đề
          'Sản phẩm đã được xóa khỏi wishlist.',
          snackPosition: SnackPosition.TOP, // Vị trí thông báo
          backgroundColor: Colors.green, // Màu nền
          colorText: Colors.white, // Màu chữ
          duration: Duration(seconds: 2), // Thời gian hiển thị
        );
      } else {
        // If the product is not in the wishlist, add it
        await WishListService.addProductToWishlist(userId, productId);
        Get.snackbar(
          'wishlist thành công', // Tiêu đề
          'Sản phẩm đã được thêm vào wishlist.',
          snackPosition: SnackPosition.TOP, // Vị trí thông báo
          backgroundColor: Colors.green, // Màu nền
          colorText: Colors.white, // Màu chữ
          duration: Duration(seconds: 2), // Thời gian hiển thị
        );
      }

      // After the API request, update the state
      isInWishlist.value = !isInWishlist.value;
    } catch (e) {
      print("Error toggling wishlist: $e");
    }
  }
}
