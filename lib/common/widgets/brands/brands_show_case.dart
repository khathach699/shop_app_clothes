import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/common/widgets/brands/brand_card.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSize.md),
      margin: const EdgeInsets.only(bottom: TSize.spaceBtwItems),
      child: Column(
        children: [
          const BrandCard(
            title: "title",
            image: TImages.shoe1,
            productCount: 3,
          ),

          const SizedBox(height: TSize.spaceBtwItems),

          Row(
            children: [
              ...images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
    child: TRoundContainer(
      height: 100,
      backgroundColor:
          THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.white,
      margin: const EdgeInsets.only(right: TSize.sm),
      padding: EdgeInsets.all(TSize.md),
      child: Image(image: AssetImage(image), fit: BoxFit.contain),
    ),
  );
}
