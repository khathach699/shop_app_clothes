import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/brands/brands_show_case.dart';
import 'package:shop_app_clothes/common/widgets/layouts/grid_layout.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              TBrandShowcase(
                images: [TImages.shoe1, TImages.shoe2, TImages.shoe3],
              ),
              // TBrandShowcase(
              //   images: [TImages.shoe1, TImages.shoe2, TImages.shoe3],
              // ),
              // TBrandShowcase(
              //   images: [TImages.shoe1, TImages.shoe2, TImages.shoe3],
              // ),
              // product
              TSectionHeading(
                title: "You might like",
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              TGridLayout(
                itemCount: 10,
                itemBuilder: (_, index) => const TProductCardVertical(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
