import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:shop_app_clothes/pages/models/Category.dart';
import 'package:shop_app_clothes/pages/service/CategoryService.dart';
import 'package:shop_app_clothes/pages/shop/category/categories.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FutureBuilder<List<CategoryResponse>>(
        future: CategoryService.getCategoriesWithProducts(),
        builder: (context, snapshot) {
          // Trạng thái lỗi
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading categories'));
          }

          // Trạng thái không có dữ liệu
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available'));
          }

          // Dữ liệu thành công
          final categories = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (_, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => CategoriesScreen(categoryId: category.id.toString()),
                  );
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
