import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/common/widgets/images/t_roundted_image.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_price_text.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_title_text.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TOrderDetail extends StatelessWidget {
  final String productName;
  final String colorName;
  final String sizeName;
  final String productImage;
  final String quantity;
  final double price;
  final int cartId; // Add cartId for deletion
  final VoidCallback onRemove; // Callback for item removal

  const TOrderDetail({
    super.key,
    required this.productName,
    required this.colorName,
    required this.sizeName,
    required this.productImage,
    required this.cartId,
    required this.onRemove,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundedImage(
              imageUrl: productImage,
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(TSize.sm),
              backgroundColor:
                  THelperFunctions.isDarkMode(context)
                      ? TColors.darkGrey
                      : TColors.light,
            ),
            SizedBox(width: TSize.spaceBtwItems),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: TProductTitleText(title: productName, maxLines: 1),
                  ),
                  SizedBox(height: TSize.spaceBtwItems), // Corrected spacing
                  Row(
                    children: [
                      Text(
                        "Color: ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        colorName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: TSize.spaceBtwItems,
                      ), // Spacing between color and size
                      Text(
                        "Size: ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        sizeName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                  // Call the remove callback
                ),
                SizedBox(height: TSize.spaceBtwItems / 2),
                TProductPriceText(price: price.toString()),
              ],
            ),
          ],
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TCircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: TSize.lg,
            ),
            const SizedBox(width: TSize.spaceBtwItems),
            Text(quantity, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: TSize.spaceBtwItems),
            TCircularIcon(
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: TSize.lg,
              // backgroundColor: TColors.primaryColor,
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
