import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shop_app_clothes/pages/shop/product_reviews/widgets/rating_profress_indicator.dart';
import 'package:shop_app_clothes/pages/shop/product_reviews/widgets/user_review_card.dart';
import 'package:shop_app_clothes/pages/service/RatingService.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TProductReview extends StatefulWidget {
  final int productId;

  const TProductReview({Key? key, required this.productId}) : super(key: key);

  @override
  _TProductReviewState createState() => _TProductReviewState();
}

class _TProductReviewState extends State<TProductReview> {
  int _totalRatings = 0;

  @override
  void initState() {
    super.initState();
    _loadTotalRatings(); // Fetch initial data
  }

  Future<void> _loadTotalRatings() async {
    try {
      final totalRatings = await RatingService().getTotalRatings(
        widget.productId,
      );
      setState(() {
        _totalRatings = totalRatings;
      });
    } catch (e) {
      print('Error loading ratings: $e');
    }
  }

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

              TOverallProductRating(productId: widget.productId),
              SizedBox(height: TSize.spaceBtwItems / 2),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TRatingBarIndicator(
                    productId: widget.productId,
                    onRatingSubmitted:
                        _loadTotalRatings, // Refresh data after submission
                  ),
                  SizedBox(width: TSize.spaceBtwItems / 2),
                  Text(
                    "Số đánh giá: $_totalRatings",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),

              SizedBox(height: TSize.spaceBtwSections),
              const Divider(),
              SizedBox(height: TSize.spaceBtwSections),
              TUserReviewCard(productId: widget.productId),
            ],
          ),
        ),
      ),
    );
  }
}
