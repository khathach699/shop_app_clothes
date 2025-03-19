import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app_clothes/pages/models/Category.dart' as category_model;
import 'package:shop_app_clothes/pages/models/Product.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/icons/t_circular_icon.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../utils/constants/size.dart';
import '../home/home.dart';
import '../../service/CategoryService.dart'; // Keep this import as is

class CategoriesScreen extends StatelessWidget {
  final String categoryId;

  const CategoriesScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: FutureBuilder<category_model.CategoryResponse>(
          future: CategoryService.getCategoryById(categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.name,
              ); // Dynamically set the category name
            } else {
              return Text("Category");
            }
          },
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: FutureBuilder<category_model.CategoryResponse>(
        future: CategoryService.getCategoryById(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                // Shimmer for banner
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: TSize.spaceBtwSections,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: TSize.spaceBtwSections),

                // Shimmer grid for products
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4, // Number of placeholders
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.products.isEmpty) {
            return Center(child: Text('No products available'));
          }

          category_model.CategoryResponse category = snapshot.data!;
          // Convert the products list from category_model.Product to Product
          List<Product> products =
              category.products
                  .map(
                    (categoryProduct) => Product(
                      id: categoryProduct.id,
                      name: categoryProduct.name,
                      price: categoryProduct.price,
                      description: categoryProduct.description,
                      image: categoryProduct.image,
                      categoryName: categoryProduct.categoryName,
                      colorSizes: [],
                    ),
                  )
                  .toList();

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSize.defaultSpace),
              child: Column(
                children: [
                  TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      return TProductCardVertical(product: products[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
