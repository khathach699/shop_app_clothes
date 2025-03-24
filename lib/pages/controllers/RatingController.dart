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
  void onInit() async {
    super.onInit();
    await _loadUserId();
  }


  Future<void> _loadUserId() async {
    userId = await StorageService.getUserId();
    print("userId: $userId");
    update();
  }

  /// Lấy dữ liệu đánh giá cho sản phẩm
  Future<void> fetchRatings(int productId) async {
    try {
      isLoading(true);
      await Future.wait([
        _fetchAverageRating(productId),
        _fetchTotalRatings(productId),
        _fetchRatingsDistribution(productId),
      ]);
    } finally {
      isLoading(false);
    }
  }

  Future<void> _fetchAverageRating(int productId) async {
    try {
      double rating = await _ratingService.getAverageRating(productId);
      averageRating.value = rating;
    } catch (e) {
      print('❌ Lỗi khi lấy đánh giá trung bình: $e');
      averageRating.value = 0.0;
    }
  }

  Future<void> _fetchTotalRatings(int productId) async {
    try {
      int total = await _ratingService.getTotalRatings(productId);
      totalRatings.value = total;
    } catch (e) {
      print('❌ Lỗi khi lấy tổng số đánh giá: $e');
      totalRatings.value = 0;
    }
  }

  Future<void> _fetchRatingsDistribution(int productId) async {
    try {
      Map<String, int> distribution = await _ratingService.getRatingsDistribution(productId);
      ratingsDistribution.value = distribution;
    } catch (e) {
      print('❌ Lỗi khi lấy phân bố đánh giá: $e');
      ratingsDistribution.value = {};
    }
  }

  /// Gửi đánh giá mới
  Future<void> submitRating(int productId) async {

    if (rating.value == 0) {
      Get.snackbar(
        'Đánh giá thất bại',
        'Vui lòng chọn số sao trước khi gửi đánh giá.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
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

      Get.snackbar(
        'Đánh giá thành công',
        'Cảm ơn bạn đã đánh giá sản phẩm của chúng tôi!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể gửi đánh giá: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting(false);
    }
  }
}
