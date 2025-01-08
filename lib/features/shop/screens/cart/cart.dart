import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get_storage/get_storage.dart';

import 'package:shop_app_clothes/utils/constants/size.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../models/Cart.dart';
import '../service/CartService.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = []; // List to hold CartItem objects
  final box = GetStorage();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  // Fetch cart items from the backend
  Future<void> _fetchCartItems() async {
    final userId = box.read('userId');
    if (userId != null) {
      try {
        // Call API to get cart items
        final items = await CartService().getCart(userId);
        setState(() {
          _cartItems.addAll(items ?? []);
          isLoading = false;
        });
      } catch (e) {
        print('Error fetching cart: $e');
        setState(() => isLoading = false);
      }
    }
  }

  // Handle item removal
  Future<void> _removeCartItem(int cartId) async {
    final success = await CartService().removeFromCart(cartId);
    if (success) {
      setState(() {
        _cartItems.removeWhere((item) => item.cartId == cartId); // Xóa item khỏi danh sách
      });

      Get.snackbar(
        'Item removed from cart!', // Title of the snackbar
        'Your item has been successfully removed to the cart.',
        snackPosition: SnackPosition.TOP, // Position at the top
        backgroundColor: Colors.lightGreen, // More vibrant green color
        colorText: Colors.white, // White text color for better contrast
        duration: Duration(seconds: 2), // Duration for which the snackbar will appear
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding
        borderRadius: 12, // Optional: Adds rounded corners for a smoother look
        snackStyle: SnackStyle.FLOATING, // Optional: Makes the snackbar floating
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to remove item.')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Padding(
        padding: const EdgeInsets.all(TSize.defaultSpace),
        child: ListView.builder(
          itemCount: _cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = _cartItems[index];
            return TCartItem(
              cartId: cartItem.cartId,
              productName: cartItem.productName,
              colorName: cartItem.colorName,
              sizeName: cartItem.sizeName,
              quantity: cartItem.quantity.toString(),
              price: cartItem.price,
              productImage: cartItem.productImage ?? '',
              onRemove: () => _removeCartItem(cartItem.cartId),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSize.defaultSpace),
        child: ElevatedButton(
          onPressed: _cartItems.isEmpty
              ? null
              : () {
            // Navigate to checkout screen
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => CheckoutScreen()),
            // );
          },
          child: Text("CheckOut \$265"),
        ),
      ),
    );
  }
}
