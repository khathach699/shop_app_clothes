import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/products/ratings/rating_indicator.dart';
import 'package:shop_app_clothes/pages/shop/product_reviews/widgets/rating_profress_indicator.dart';
import 'package:shop_app_clothes/pages/shop/product_reviews/widgets/user_review_card.dart';

import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../controllers/RatingController.dart';

class TProductReview extends StatelessWidget {
  final int productId;
  TProductReview({Key? key, required this.productId}) : super(key: key);

  final RatingController ratingController = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    ratingController.fetchRatings(productId); // Fetch ratings khi vào trang

    return Scaffold(
      appBar: TAppBar(title: const Text("Reviews & Ratings")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Reviews & Ratings"),
            const SizedBox(height: TSize.spaceBtwSections),

            // Hiển thị đánh giá tổng quát
            TOverallProductRating(productId: productId),
            const SizedBox(height: TSize.spaceBtwItems / 2),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TRatingBarIndicator(
                  productId: productId,
                  onRatingSubmitted: () => ratingController.fetchRatings(productId),
                ),
                const SizedBox(width: TSize.spaceBtwItems / 2),

                // Số lượng đánh giá
                Obx(() => Text(
                  "Số đánh giá: ${ratingController.totalRatings}",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
              ],
            ),

            const SizedBox(height: TSize.spaceBtwSections),
            const Divider(),
            const SizedBox(height: TSize.spaceBtwSections),

            TUserReviewCard(productId: productId),
          ],
        ),
      ),
    );
  }
}
