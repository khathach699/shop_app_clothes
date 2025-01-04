import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shop_app_clothes/features/shop/screens/product_reviews/widgets/rating_profress_indicator.dart';
import 'package:shop_app_clothes/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TProductReview extends StatelessWidget {
  const TProductReview({super.key});

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
              TUserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
