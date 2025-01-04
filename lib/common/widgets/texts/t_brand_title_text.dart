import 'package:flutter/material.dart';
import 'package:shop_app_clothes/utils/constants/enums.dart';

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.color,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSize.small,
  });

  final String title;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextSize brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,

      style:
          brandTextSize == TextSize.small
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
              : brandTextSize == TextSize.medium
              ? Theme.of(context).textTheme.labelLarge!.apply(color: color)
              : brandTextSize == TextSize.large
              ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
              : Theme.of(context).textTheme.headlineLarge!.apply(color: color),
    );
  }
}
