import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/products/cart/add_remove_button.dart';
import 'package:shop_app_clothes/common/widgets/products/cart/cart_item.dart';
import 'package:shop_app_clothes/common/widgets/texts/product_price_text.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder:
          (_, __) => const SizedBox(height: TSize.spaceBtwSections),
      itemCount: 2,

      itemBuilder:
          (_, index) => Column(
            children: [
              TCartItem(),
              if (showAddRemoveButtons)
                const SizedBox(height: TSize.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        TProductQuantityWithAddAndRemoveButton(),
                      ],
                    ),
                    TProductPriceText(price: "265"),
                  ],
                ),
              Divider(),
            ],
          ),
    );
  }
}
