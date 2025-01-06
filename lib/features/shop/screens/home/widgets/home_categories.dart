import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:shop_app_clothes/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:shop_app_clothes/features/shop/models/Category.dart';
import 'package:shop_app_clothes/features/shop/screens/category/categories.dart';
import 'package:shop_app_clothes/features/shop/screens/service/CategoryService.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
// Import model CategoryResponse

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FutureBuilder<List<CategoryResponse>>(
        future:
            CategoryService.getCategoriesWithProducts(), // Gọi service để lấy dữ liệu
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            ); // Hiển thị loading khi đang lấy dữ liệu
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Xử lý lỗi
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No categories available'),
            ); // Không có dữ liệu
          }

          // Dữ liệu đã được lấy thành công, hiển thị danh sách
          List<CategoryResponse> categories = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              // Hiển thị mỗi danh mục
              var category = categories[index];
              return TVerticalImageText(
                image: category.image, // Đổi thành ảnh của danh mục
                title: category.name, // Đổi thành tên danh mục
                // onTap: () => Get.to(() => CategoriesScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
