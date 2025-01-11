import 'package:flutter/material.dart';
import 'package:shop_app_clothes/features/shop/screens/product_reviews/widgets/rating_progress_and%20_rating.dart';
import 'package:shop_app_clothes/features/shop/service/RatingService.dart';

class TOverallProductRating extends StatelessWidget {
  final int productId;

  const TOverallProductRating({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getRatingData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final double averageRating = snapshot.data?['averageRating'] ?? 0.0;
          final Map<String, int> ratings = snapshot.data?['ratings'] ?? {};

          // Tổng số đánh giá
          int totalRatings = ratings.values.fold(
            0,
            (sum, count) => sum + count,
          );

          // Tính tỷ lệ phần trăm cho mỗi mức sao
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
                  children: [
                    TRatingProgressIndicator(
                      text: '5',
                      value: getRatingPercentage(5),
                    ),
                    TRatingProgressIndicator(
                      text: '4',
                      value: getRatingPercentage(4),
                    ),
                    TRatingProgressIndicator(
                      text: '3',
                      value: getRatingPercentage(3),
                    ),
                    TRatingProgressIndicator(
                      text: '2',
                      value: getRatingPercentage(2),
                    ),
                    TRatingProgressIndicator(
                      text: '1',
                      value: getRatingPercentage(1),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }

  Future<Map<String, dynamic>> _getRatingData() async {
    RatingService ratingService = RatingService();
    try {
      double averageRating = await ratingService.getAverageRating(productId);
      Map<String, int> ratings = await ratingService.getRatingsDistribution(
        productId,
      );

      return {'averageRating': averageRating, 'ratings': ratings};
    } catch (e) {
      print('Error fetching rating data: $e');
      return {'averageRating': 0.0, 'ratings': {}};
    }
  }
}
