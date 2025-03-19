import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';

import 'package:shop_app_clothes/pages/shop/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:shop_app_clothes/pages/shop/product_details/widgets/product_atriibutes.dart';
import 'package:shop_app_clothes/pages/shop/product_details/widgets/product_detail_image_slider.dart';
import 'package:shop_app_clothes/pages/shop/product_details/widgets/product_meta_data.dart';
import 'package:shop_app_clothes/pages/shop/product_details/widgets/rating_share_widget.dart';
import 'package:shop_app_clothes/pages/shop/product_reviews/product_review.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: TBottomAddToCartWidGet(
        productId: product.id,
        productImage: product.image,
        price: product.price,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product image
            TProductImageSlider(dark: dark, product: product),
            // product detail
            Padding(
              padding: const EdgeInsets.only(
                right: TSize.defaultSpace,
                left: TSize.defaultSpace,
                bottom: TSize.defaultSpace,
              ),
              child: Column(
                children: [
                  // Rating and Share
                  TRateAndShare(productId: product.id),
                  // price / title
                  TProductMetaDate(product: product),
                  Divider(),

                  // attributes
                  TProductAttributes(product: product),
                  SizedBox(height: TSize.spaceBtwSections),

                  Divider(),
                  SizedBox(height: TSize.spaceBtwSections),
                  // description
                  const TSectionHeading(
                    title: "Description",
                    showActionButton: false,
                  ),
                  SizedBox(height: TSize.spaceBtwItems),
                  ReadMoreText(
                    product.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: " Show less",
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: "Review",
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed:
                            () => Get.to(
                              () => TProductReview(productId: product.id),
                            ),
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),
                  // Review
                  SizedBox(height: TSize.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
