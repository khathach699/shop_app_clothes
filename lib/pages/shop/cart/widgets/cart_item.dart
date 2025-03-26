import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/products/cart/cart_item.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../../models/Cart.dart'; // Assuming you have a CartItem model

class TCartItems extends StatelessWidget {
  final List<CartItem>
  cartItems; // Dữ liệu giỏ hàng, defined with CartItem type
  final bool showAddRemoveButtons;
  final Function(int) onRemoveItem; // Callback for item removal

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
              quantity: cartItem.quantity.toString(),
              price: cartItem.price,
              cartId:
                  cartItem
                      .cartId,
              onRemove:
                  () =>
                      onRemoveItem(cartItem.cartId),
            ),


          ],
        );
      },
    );
  }
}
