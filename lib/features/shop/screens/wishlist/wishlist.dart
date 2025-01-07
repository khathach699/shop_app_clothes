import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/features/shop/models/Product.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../service/WishlistService.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Product> wishlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    final box = GetStorage();
    int? userId = box.read('userId'); // Lấy userId từ GetStorage
    if (userId != null) {
      try {
        List<Product> fetchedWishlist =
        await WishListService.getWishlist(userId);
        setState(() {
          wishlist = fetchedWishlist;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch wishlist: $e')),
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlist.isEmpty
          ? const Center(child: Text('Your wishlist is empty.'))
          : Padding(
        padding: EdgeInsets.all(TSize.defaultSpace),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: wishlist.length,
          itemBuilder: (_, index) => TProductCardVertical(
            product: wishlist[index],
          ),
        ),
      ),
    );
  }
}