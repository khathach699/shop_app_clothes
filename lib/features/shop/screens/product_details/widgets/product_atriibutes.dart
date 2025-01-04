import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/chips/choice_chip.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: "Colors", showActionButton: false),
            const SizedBox(height: TSize.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                  text: "Green",
                  selected: true,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: "Blue",
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: "Yellow",
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: "Black",
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: "Pink",
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: "Purple",
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: "Red",
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: TSize.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: "Size", showActionButton: false),
            SizedBox(height: TSize.spaceBtwItems / 2),
            Wrap(
              spacing: 12,
              children: [
                TChoiceChip(text: "S", selected: true, onSelected: (value) {}),
                TChoiceChip(text: "M", selected: false, onSelected: (value) {}),
                TChoiceChip(text: "L", selected: false, onSelected: (value) {}),
                TChoiceChip(text: "XL", selected: true, onSelected: (value) {}),
                TChoiceChip(
                  text: "XXL",
                  selected: true,
                  onSelected: (value) {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
