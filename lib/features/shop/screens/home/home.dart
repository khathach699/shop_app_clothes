import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/primary_header_primary.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/search_container.dart';
import 'package:shop_app_clothes/common/widgets/layouts/grid_layout.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shop_app_clothes/features/shop/screens/home/widgets/home_categories.dart';
import 'package:shop_app_clothes/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  const SizedBox(height: TSize.spaceBtwSections),
                  TSearchContainer(text: "Search in store"),
                  const SizedBox(height: TSize.spaceBtwSections / 2),

                  Padding(
                    padding: const EdgeInsets.only(left: TSize.defaultSpace),
                    child: Column(
                      children: [
                        //heading
                        TSectionHeading(
                          title: "Popular Categories",
                          showActionButton: false,
                          textColor: TColors.white,
                        ),

                        // Categories
                        THomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Home
            Padding(
              padding: EdgeInsets.all(TSize.defaultSpace),
              child: Column(
                children: [
                  TPromoSlider(
                    banner: [TImages.shoe1, TImages.shoe2, TImages.shoe3],
                  ),

                  const SizedBox(height: TSize.spaceBtwSections),
                  TGridLayout(
                    itemCount: 10,
                    itemBuilder: (_, index) => const TProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
