import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app_clothes/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:shop_app_clothes/pages/models/Category.dart';
import 'package:shop_app_clothes/pages/shop/category/categories.dart';
import 'package:shop_app_clothes/pages/service/CategoryService.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

// Import model CategoryResponse
class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FutureBuilder<List<CategoryResponse>>(
        future: CategoryService.getCategoriesWithProducts(),
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
                  itemCount: 6, // Number of placeholders
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

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories available'));
          }

          List<CategoryResponse> categories = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              var category = categories[index];
              return GestureDetector(
                onTap: () {
                  // Ensure categoryId is valid
                  if (category.id != null) {
                    Get.to(
                      () => CategoriesScreen(
                        categoryId: category.id.toString(),
                      ), // category.id should be valid here
                    );
                  } else {
                    print(
                      "Invalid category ID: ${category.id}",
                    ); // Log the issue if id is invalid
                  }
                },

                child: TVerticalImageText(
                  image: category.image,
                  title: category.name,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
