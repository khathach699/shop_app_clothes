import 'package:flutter/material.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({super.key, required this.dividerText});
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            thickness: 0.8,
            indent: 60,
            endIndent: 5,
          ),
        ),
        const SizedBox(width: TSize.spaceBtwItems),
        Text(dividerText),
        const SizedBox(width: TSize.spaceBtwItems),
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            thickness: 0.8,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
