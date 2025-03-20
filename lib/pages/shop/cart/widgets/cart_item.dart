import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/products/cart/cart_item.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../../models/Cart.dart';

class TCartItems extends StatelessWidget {
  final List<CartItem> cartItems;
  final bool showAddRemoveButtons;
  final Function(int) onRemoveItem;

  const TCartItems({
    super.key,
    required this.cartItems,
    this.showAddRemoveButtons = true,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder:
          (_, __) => const SizedBox(height: TSize.spaceBtwSections),
      itemCount: cartItems.length,
      itemBuilder: (_, index) {
        final cartItem = cartItems[index];

        return Column(
          children: [
            TCartItem(
              productName: cartItem.productName,
              colorName: cartItem.colorName,
              sizeName: cartItem.sizeName,
              productImage: cartItem.productName,
              quantity: cartItem.quantity.toString(), // Pass quantity here
              price: cartItem.price,
              cartId:
                  cartItem
                      .cartId, // Assuming you have cartId to remove the item
              onRemove:
                  () =>
                      onRemoveItem(cartItem.cartId), // Pass the remove callback
            ),

            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         const SizedBox(width: 70),
            //         TProductQuantityWithAddAndRemoveButton(
            //           quantity: cartItem.quantity.toString(),
            //         ),
            //       ],
            //     ),
            //     TProductPriceText(price: cartItem.price.toString()),
            //   ],
            // ),
            // Divider(),

            // if (showAddRemoveButtons ) const SizedBox(height: TSize.spaceBtwItems),
            // if (showAddRemoveButtons)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: [
            //           const SizedBox(width: 70),
            //           TProductQuantityWithAddAndRemoveButton(
            //             quantity: cartItem.quantity.toString(),
            //           ),
            //         ],
            //       ),
            //       TProductPriceText(price: cartItem.price.toString()),
            //     ],
            //   ),
            // Divider(),
          ],
        );
      },
    );
  }
}
