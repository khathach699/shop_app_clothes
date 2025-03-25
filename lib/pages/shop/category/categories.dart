import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/pages/models/Category.dart' as category_model;
import 'package:shop_app_clothes/pages/models/Product.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/icons/t_circular_icon.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../utils/constants/size.dart';
import '../../service/CategoryService.dart';
import '../home/home.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryService _categoryService = CategoryService();
  final int categoryId;

  CategoriesScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: FutureBuilder<category_model.CategoryResponse>(
          future: _categoryService.getCategoryById(categoryId),
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
      body: SingleChildScrollView(
        child: FutureBuilder<category_model.CategoryResponse>(
          future: _categoryService.getCategoryById(categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Replace shimmer with a regular Container
                    Container(
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
                    const SizedBox(height: TSize.spaceBtwSections),
        
                    // Replace shimmer with a regular GridView
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(), // Không cuộn độc lập
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: 4, // Replace with actual product count once data is fetched
                        itemBuilder: (context, index) {
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
        
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
        
            if (!snapshot.hasData || snapshot.data!.products.isEmpty) {
              return Center(child: Text('No products available'));
            }
        
            // Hiển thị danh sách sản phẩm thật
            category_model.CategoryResponse category = snapshot.data!;
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
                colorSizes: [
                  ColorSize(
                    colorName: categoryProduct.colorSizes[0].colorName,
                    sizeName: categoryProduct.colorSizes[0].sizeName,
                    quantity: categoryProduct.colorSizes[0].quantity,
                  ),
                ],
              ),
            ).toList();

            return Padding(
              padding: EdgeInsets.all(TSize.defaultSpace),
              child: TGridLayout(
                itemCount: products.length,
                itemBuilder: (_, index) {
                  return TProductCardVertical(product: products[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
