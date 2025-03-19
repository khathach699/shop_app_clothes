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

import '../../../models/Product.dart';

class TProductMetaDate extends StatelessWidget {
  final Product product;
  const TProductMetaDate({super.key, required this.product});

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
            TProductPriceText(price: product.price.toString(), isLarge: true),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems / 1.5),
        TProductTitleText(title: product.name),
        SizedBox(height: TSize.spaceBtwItems / 1.5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Store: ", style: Theme.of(context).textTheme.titleMedium),
                SizedBox(width: TSize.spaceBtwItems),
                TProductTitleText(
                  title: product.colorSizes.first.quantity.toString(),
                ), // Dùng first hoặc một phương thức lấy chính xác phần tử
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
                TBrandTitleWithVerifiedIcon(
                  title: product.categoryName,
                  brandTextSize: TextSize.medium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
