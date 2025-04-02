import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:shop_app_clothes/pages/models/Category.dart';
import 'package:shop_app_clothes/pages/shop/category/categories.dart';
import 'package:shop_app_clothes/pages/service/CategoryService.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class THomeCategories extends StatelessWidget {
  final CategoryService _categoryService = CategoryService();

  THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FutureBuilder<List<CategoryResponse>>(
        future: _categoryService.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Khi có lỗi
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Khi không có dữ liệu
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available'));
          }

          // Khi có dữ liệu
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
                        categoryId: category.id,
                      ), // category.id should be valid here
                    );
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