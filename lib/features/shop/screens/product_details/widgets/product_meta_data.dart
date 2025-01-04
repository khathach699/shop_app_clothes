import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/common/widgets/images/t_circular_Image.dart';
import 'package:shop_app_clothes/common/widgets/texts/branch_title_with_verified_icon.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_price_text.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_title_text.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/enums.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TProductMetaDate extends StatelessWidget {
  const TProductMetaDate({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundContainer(
              radius: TSize.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: EdgeInsets.symmetric(
                horizontal: TSize.sm,
                vertical: TSize.xs,
              ),
              child: Text(
                "25%",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.apply(color: TColors.black),
              ),
            ),

            SizedBox(width: TSize.spaceBtwItems),

            // price
            Text(
              "\$250",
              style: Theme.of(context).textTheme.titleSmall!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: TSize.spaceBtwItems),
            TProductPriceText(price: "200", isLarge: true),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems / 1.5),
        const TProductTitleText(title: "Green Dress"),
        SizedBox(height: TSize.spaceBtwItems / 1.5),

        Row(
          children: [
            const TProductTitleText(title: "Status"),
            SizedBox(width: TSize.spaceBtwItems),
            Text("In Stock", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(height: TSize.spaceBtwItems / 1.5),

        // brand
        Row(
          children: [
            TCircularImage(
              image: TImages.lightAppLogo,
              width: 32,
              height: 32,

              // overlayColor: dark ? TColors.white : TColors.black,
            ),
            const TBrandTitleWithVerifiedIcon(
              title: "Nike",
              brandTextSize: TextSize.medium,
            ),
          ],
        ),
      ],
    );
  }
}
