import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/shop/product_reviews/widgets/rating_progress_and%20_rating.dart';

import '../../../controllers/RatingController.dart';

class TOverallProductRating extends StatelessWidget {
  final int productId;
  TOverallProductRating({super.key, required this.productId});

  final RatingController ratingController = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    ratingController.fetchRatings(productId);

    return Obx(() {
      if (ratingController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final double averageRating = ratingController.averageRating.value;
      final Map<String, int> ratings = ratingController.ratingsDistribution;
      final int totalRatings = ratingController.totalRatings.value;

      double getRatingPercentage(int star) {
        int count = ratings[star.toString()] ?? 0;
        return totalRatings > 0 ? count / totalRatings : 0.0;
      }

      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              averageRating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: List.generate(5, (index) {
                int star = 5 - index;
                return TRatingProgressIndicator(
                  text: star.toString(),
                  value: getRatingPercentage(star),
                );
              }),
            ),
          ),
        ],
      );
    });
  }
}
