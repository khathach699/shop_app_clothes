import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shop_app_clothes/features/shop/screens/product_reviews/widgets/rating_profress_indicator.dart';
import 'package:shop_app_clothes/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/features/shop/service/RatingService.dart';

class TProductReview extends StatelessWidget {
  final int productId; // Receive productId as a parameter

  const TProductReview({
    super.key,
    required this.productId,
  }); // Constructor with productId

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text("Reviews & Ratings")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reviews & Ratings"),
              SizedBox(height: TSize.spaceBtwSections),

              TOverallProductRating(productId: productId),

              TRatingBarIndicator(productId: productId),

              // FutureBuilder to get total ratings count
              FutureBuilder<int>(
                future: _getTotalRatings(), // Call the API to get total ratings
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data?.toString() ??
                          "0", // Display total ratings count
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
              SizedBox(height: TSize.spaceBtwSections),
              const Divider(),
              SizedBox(height: TSize.spaceBtwSections),
              TUserReviewCard(
                productId: productId,
              ), // Pass productId to TUserReviewCard
            ],
          ),
        ),
      ),
    );
  }

  // Fetch total number of ratings for the product
  // Fetch total number of ratings for the product
  // Fetch total number of ratings for the product
  Future<int> _getTotalRatings() async {
    RatingService ratingService = RatingService();

    try {
      // Get total ratings count from API
      int totalRatings = await ratingService.getTotalRatings(
        productId,
      ); // Use getTotalRatings instead of getAverageRating
      return totalRatings; // Return the total ratings count
    } catch (e) {
      // Handle error
      print('Error fetching total ratings: $e');
      // Return a default value of 0 if there's an error
      return 0;
    }
  }
}
