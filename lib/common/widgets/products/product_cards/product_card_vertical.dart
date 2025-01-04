import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/styles/shadowns.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/common/widgets/images/t_roundted_image.dart';
import 'package:shop_app_clothes/common/widgets/texts/branch_title_with_verified_icon.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_price_text.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_title_text.dart';
import 'package:shop_app_clothes/features/shop/screens/product_details/product_detail.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetail()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSize.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          children: [
            TRoundContainer(
              height: 180,
              padding: const EdgeInsets.all(TSize.sm),
              backgroundColor: dark ? TColors.dart : TColors.light,
              child: Stack(
                children: [
                  TRoundedImage(
                    imageUrl: TImages.shoe1,
                    applyImageRadius: true,
                  ),

                  Positioned(
                    top: 12,
                    child: TRoundContainer(
                      radius: TSize.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSize.sm,
                        vertical: TSize.xs,
                      ),
                      child: Text(
                        "25%",
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: TColors.black),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSize.spaceBtwItems / 2),

            Padding(
              padding: const EdgeInsets.only(left: TSize.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(
                    title: "Green Nike Air Shoes",
                    smallSize: true,
                  ),

                  const SizedBox(height: TSize.spaceBtwItems / 2),
                  Row(
                    children: [
                      TBrandTitleWithVerifiedIcon(title: 'Nike'),
                      const SizedBox(width: TSize.xs),
                      const Icon(
                        Iconsax.verify5,
                        color: TColors.primaryColor,
                        size: TSize.iconXs,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSize.sm),
                  child: const TProductPriceText(price: "35.5"),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dart,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSize.cardRadiusMd),
                      bottomRight: Radius.circular(TSize.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: TSize.iconLg * 1.2,
                    height: TSize.iconLg * 1.2,
                    child: Icon(Iconsax.add, color: TColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
