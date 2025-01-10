import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TRateAndShare extends StatelessWidget {
  const TRateAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    void _shareProduct() {
      final String productLink = "http://10.0.2.2:8080/api/products";
      final String shareText =
          '✨ Khám phá ngay sản phẩm tuyệt vời tại cửa hàng của tôi! 🛒\n\n🔗 Xem chi tiết tại: $productLink\n\nHãy ghé qua và lựa chọn món đồ yêu thích của bạn! ❤️';
      Share.share(shareText);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Iconsax.star5, color: Colors.yellow, size: 24),
            const SizedBox(width: TSize.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                text: '4.5',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: ' (23 reviews)',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
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
  }
}
