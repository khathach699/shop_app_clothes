import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:shop_app_clothes/features/shop/models/Category.dart';
import 'package:shop_app_clothes/features/shop/screens/category/categories.dart';
import 'package:shop_app_clothes/features/shop/screens/service/CategoryService.dart';

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
            return Center(child: CircularProgressIndicator());
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
