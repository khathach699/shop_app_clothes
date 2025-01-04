import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';

import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TBottomAddToCartWidGet extends StatelessWidget {
  const TBottomAddToCartWidGet({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSize.defaultSpace,
        vertical: TSize.spaceBtwItems,
      ),
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSize.cardRadiusLg),
          topRight: Radius.circular(TSize.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.grey,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: TSize.spaceBtwItems),
              Text("2", style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSize.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.grey,
                width: 40,
                height: 40,
                color: Colors.white,
              ),
            ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSize.md),
              backgroundColor: TColors.black,
              side: BorderSide(color: TColors.black),
            ),
            child: Text("Add to Cart"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
