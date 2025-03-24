import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../pages/controllers/RatingController.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.productId,
    required this.onRatingSubmitted,
  });

  final int productId;
  final VoidCallback onRatingSubmitted;

  @override
  Widget build(BuildContext context) {
    final RatingController ratingController = Get.find<RatingController>();

    return Column(
      children: [
        Obx(() => RatingBar.builder(
          initialRating: ratingController.rating.value,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, _) =>
          const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) =>
          ratingController.rating.value = rating,
        )),
        const SizedBox(height: 8),
        Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: ratingController.isSubmitting.value
              ? null
              : () async {

            await ratingController.submitRating(productId);
            onRatingSubmitted();
          },
          child: ratingController.isSubmitting.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Gửi Đánh Giá', style: TextStyle(fontSize: 14)),
        )),
      ],
    );
  }
}
