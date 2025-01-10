import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/primary_header_primary.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/search_container.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/models/Product.dart';
import 'package:shop_app_clothes/features/shop/screens/all_products/all_products.dart';
import 'package:shop_app_clothes/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:shop_app_clothes/features/shop/screens/home/widgets/home_categories.dart';
import 'package:shop_app_clothes/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:shop_app_clothes/features/shop/screens/service/ProductService.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ProductService.getAllProducts(); // Fetch products on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  const SizedBox(height: TSize.spaceBtwSections),
                  TSearchContainer(
                    text: "Search in store",
                    padding: const EdgeInsets.all(TSize.md),
                  ),
                  const SizedBox(height: TSize.spaceBtwSections / 2),

                  Padding(
                    padding: const EdgeInsets.only(left: TSize.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        TSectionHeading(
                          title: "Popular Categories",
                          showActionButton: false,
                          textColor: TColors.white,
                          onPressed: () {},
                        ),
                        // Categories
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSize.spaceBtwSections * 1.5),
                ],
              ),
            ),

            // Home
            Padding(
              padding: EdgeInsets.all(TSize.defaultSpace),
              child: Column(
                children: [
                  FutureBuilder<List<Product>>(
                    future: products,
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
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No products found'));
                      } else {
                        final productList = snapshot.data!;

                        // Lấy hình ảnh của sản phẩm để làm banner
                        List<String> imageList =
                            productList.isNotEmpty
                                ? productList
                                    .map((product) => product.image)
                                    .toList()
                                : [TImages.shoe1]; // fallback image

                        return Column(
                          children: [
                            TPromoSlider(
                              banner: imageList,
                              products: productList, // Pass the product list
                            ),
                            const SizedBox(height: TSize.spaceBtwSections),
                            TSectionHeading(
                              title: "New Arrivals",
                              buttonTitle: "View All",
                              onPressed: () => Get.to(() => AllProducts()),
                            ),
                            const SizedBox(height: TSize.spaceBtwItems / 2),

                            // Grid of products
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                final product = productList[index];
                                return TProductCardVertical(product: product);
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
