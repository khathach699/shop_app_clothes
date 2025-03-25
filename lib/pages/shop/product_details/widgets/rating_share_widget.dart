import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app_clothes/pages/service/RatingService.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TRateAndShare extends StatelessWidget {
  final int productId; // Thêm productId để lấy thông tin cho sản phẩm cụ thể

  const TRateAndShare({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    void _shareProduct() {
      final String productLink = "http://10.0.2.2:8080/api/products";
      final String shareText =
          '✨ Khám phá ngay sản phẩm tuyệt vời tại cửa hàng của tôi! 🛒\n\n🔗 Xem chi tiết tại: $productLink\n\nHãy ghé qua và lựa chọn món đồ yêu thích của bạn! ❤️';
      Share.share(shareText);
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: _getRatingData(), // Lấy dữ liệu đánh giá
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Đang chờ dữ liệu
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final double averageRating = snapshot.data?['averageRating'] ?? 0.0;
          final int totalRatings = snapshot.data?['totalRatings'] ?? 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Iconsax.star5, color: Colors.yellow, size: 24),
                  const SizedBox(width: TSize.spaceBtwItems / 2),
                  Text.rich(
                    TextSpan(
                      text: averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: ' ($totalRatings reviews)',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Share Icon
              IconButton(
                onPressed: _shareProduct,
                icon: const Icon(Icons.share, size: 24),
              ),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }

  // Hàm gọi API để lấy dữ liệu điểm trung bình và tổng số đánh giá
  Future<Map<String, dynamic>> _getRatingData() async {
    // Khởi tạo RatingService
    RatingService ratingService = RatingService();

    try {
      // Lấy thông tin đánh giá từ API
      double averageRating = await ratingService.getAverageRating(productId);
      int totalRatings = await ratingService.getTotalRatings(productId);

      return {'averageRating': averageRating, 'totalRatings': totalRatings};
    } catch (e) {
      // Xử lý khi có lỗi xảy ra

      return {'averageRating': 0.0, 'totalRatings': 0};
    }
  }
}
