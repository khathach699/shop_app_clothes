import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/images/t_roundted_image.dart';
import 'package:shop_app_clothes/common/widgets/texts/branch_title_with_verified_icon.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_title_text.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({super.key});

  // Hàm trả về TextSpan để làm nội dung cho Text.rich
  TextSpan _buildProductDetails(BuildContext context) {
    return TextSpan(
      children: [
        TextSpan(text: "Color: ", style: Theme.of(context).textTheme.bodySmall),
        TextSpan(text: "Green ", style: Theme.of(context).textTheme.bodyLarge),
        TextSpan(text: "Size: ", style: Theme.of(context).textTheme.bodySmall),
        TextSpan(text: "XXXL", style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: TImages.shoe2,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSize.sm),
          backgroundColor:
              THelperFunctions.isDarkMode(context)
                  ? TColors.darkGrey
                  : TColors.light,
        ),
        SizedBox(width: TSize.spaceBtwItems),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifiedIcon(title: "Nike"),
              const Flexible(
                child: TProductTitleText(
                  title: "Black sport Shoes",
                  maxLines: 1,
                ),
              ),
              Text.rich(_buildProductDetails(context)),
            ],
          ),
        ),
      ],
    );
  }
}
