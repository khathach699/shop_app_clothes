import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/icons/t_circular_icon.dart';
import 'package:shop_app_clothes/features/shop/screens/home/home.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),

      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.all(TSize.defaultSpace),
      //     child: Column(
      //       children: [
      //         TGridLayout(
      //           itemCount: 10,
      //           itemBuilder:
      //               (_, index) => const TProductCardVertical(product: null),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
