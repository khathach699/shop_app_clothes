import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/layouts/grid_layout.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text("All products"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              DropdownButtonFormField(
                items:
                    ['Name', 'Higher Price', 'Lower Price', 'Sale', 'New']
                        .map(
                          (option) => DropdownMenuItem(
                            child: Text(option),
                            value: option,
                          ),
                        )
                        .toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.sort),
                ),
              ),
              const SizedBox(height: TSize.spaceBtwSections),

              TGridLayout(
                itemCount: 10,
                itemBuilder: (_, index) => TProductCardVertical(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
