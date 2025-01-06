import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/common/widgets/images/t_roundted_image.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../../models/Product.dart';

class TProductImageSlider extends StatelessWidget {
  final Product product;
  const TProductImageSlider({
    super.key,
    required this.dark,
    required this.product,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TCurveEdgeWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSize.productImageRadius * 2),
                child: Image(image: NetworkImage(product.image)),
              ),
            ),

            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSize.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder:
                      (_, index) => TRoundedImage(
                        imageUrl: product.image,
                        width: 80,
                        backgroundColor: dark ? TColors.dart : TColors.light,
                        border: Border.all(color: TColors.primaryColor),
                        padding: const EdgeInsets.all(TSize.sm),
                      ),
                  separatorBuilder:
                      (_, __) => const SizedBox(width: TSize.spaceBtwItems),
                  itemCount: 6,
                ),
              ),
            ),

            TAppBar(
              showBackArrow: true,
              actions: [TCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
            ),
          ],
        ),
      ),
    );
  }
}
