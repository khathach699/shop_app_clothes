import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shop_app_clothes/features/shop/screens/product_reviews/widgets/rating_profress_indicator.dart';
import 'package:shop_app_clothes/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

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

              TOverallProductRating(),

              TRatingBarIndicator(rating: 3.5),
              Text("12.366", style: Theme.of(context).textTheme.bodySmall),
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
}
