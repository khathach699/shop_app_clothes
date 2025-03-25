import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/models/Rating.dart';
import 'package:shop_app_clothes/pages/service/RatingService.dart';
import '../service/StorageService.dart';

class RatingController extends GetxController {
  final RatingService _ratingService = RatingService();

  var averageRating = 0.0.obs;
  var totalRatings = 0.obs;
  var ratingsDistribution = <String, int>{}.obs;
  var isLoading = false.obs;
  var isSubmitting = false.obs;
  var rating = 0.0.obs;
  int? userId;

  @override
  void onReady() async {
    super.onReady();
    await _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await StorageService.getUserId();
    update();
  }

  /// Lấy dữ liệu đánh giá cho sản phẩm
  Future<void> fetchRatings(int productId) async {
    isLoading(true);
    await Future.wait([
      _fetchAverageRating(productId),
      _fetchTotalRatings(productId),
      _fetchRatingsDistribution(productId),
    ]);
    isLoading(false);
  }

  Future<void> _fetchAverageRating(int productId) async {
    try {
      averageRating.value = await _ratingService.getAverageRating(productId);
    } catch (e) {
      averageRating.value = 0.0;
      debugPrint('❌ Lỗi khi lấy đánh giá trung bình: $e');
    }
  }

  Future<void> _fetchTotalRatings(int productId) async {
    try {
      totalRatings.value = await _ratingService.getTotalRatings(productId);
    } catch (e) {
      totalRatings.value = 0;
      debugPrint('❌ Lỗi khi lấy tổng số đánh giá: $e');
    }
  }

  Future<void> _fetchRatingsDistribution(int productId) async {
    try {
      ratingsDistribution.value = await _ratingService.getRatingsDistribution(productId);
    } catch (e) {
      ratingsDistribution.value = {};
      debugPrint('❌ Lỗi khi lấy phân bố đánh giá: $e');
    }
  }

  /// Gửi đánh giá mới
  Future<void> submitRating(int productId) async {
    if (rating.value == 0) {
      _showErrorSnackbar('Đánh giá thất bại', 'Vui lòng chọn số sao trước khi gửi đánh giá.');
      return;
    }

    try {
      isSubmitting(true);
      Rating newRating = Rating(
        userId: userId!,
        productId: productId,
        score: rating.value.clamp(1, 5).toInt(),
      );

      await _ratingService.addRating(newRating);
      await fetchRatings(productId); // Cập nhật dữ liệu sau khi gửi đánh giá

      _showSuccessSnackbar('Đánh giá thành công', 'Cảm ơn bạn đã đánh giá sản phẩm của chúng tôi!');
    } catch (e) {
      _showErrorSnackbar('Lỗi', 'Không thể gửi đánh giá: $e');
    } finally {
      isSubmitting(false);
    }
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
