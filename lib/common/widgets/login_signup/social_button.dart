import 'package:flutter/material.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TSocialButton extends StatelessWidget {
  const TSocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: TSize.imageWidth,
          height: TSize.imageWidth,
          decoration: BoxDecoration(
            border: Border.all(color: dark ? TColors.darkGrey : TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(TImages.google),
              width: TSize.iconXl,
              height: TSize.iconXl,
            ),
          ),
        ),

        SizedBox(width: TSize.spaceBtwItems),
        Container(
          width: TSize.imageWidth,
          height: TSize.imageWidth,
          decoration: BoxDecoration(
            border: Border.all(color: dark ? TColors.darkGrey : TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(TImages.facebook),
              width: TSize.iconXl,
              height: TSize.iconXl,
            ),
          ),
        ),
      ],
    );
  }
}
