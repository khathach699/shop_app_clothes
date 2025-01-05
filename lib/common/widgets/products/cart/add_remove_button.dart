import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TProductQuantityWithAddAndRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddAndRemoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: TSize.lg,
        ),
        const SizedBox(width: TSize.spaceBtwItems),
        Text("2", style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: TSize.spaceBtwItems),
        TCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: TSize.lg,
          // backgroundColor: TColors.primaryColor,
        ),
      ],
    );
  }
}
