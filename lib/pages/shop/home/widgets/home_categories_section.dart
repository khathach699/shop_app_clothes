// Widget cho phần Categories
import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/pages/shop/home/widgets/home_categories.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: TSize.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(
            title: "Popular Categories",
            showActionButton: false,
            textColor: TColors.white,
          ),
          const THomeCategories(),
        ],
      ),
    );
  }
}
