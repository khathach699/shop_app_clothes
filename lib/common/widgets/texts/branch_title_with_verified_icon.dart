import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as TextAline;
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/texts/t_brand_title_text.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/enums.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primaryColor,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSize.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSize brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            maxLines: maxLines,
            color: textColor,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: TSize.xs),
        Icon(Iconsax.verify5, color: iconColor, size: TSize.iconXs),
      ],
    );
  }
}
