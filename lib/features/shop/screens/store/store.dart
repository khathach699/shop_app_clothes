import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/appbar/tabbar.dart';
import 'package:shop_app_clothes/common/widgets/brands/brand_card.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/search_container.dart';
import 'package:shop_app_clothes/common/widgets/layouts/grid_layout.dart';
import 'package:shop_app_clothes/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/models/Category.dart';
import 'package:shop_app_clothes/features/shop/screens/all_products/all_products.dart';
import 'package:shop_app_clothes/features/shop/screens/store/widgets/Category_tab2.dart';
import 'package:shop_app_clothes/features/shop/screens/store/widgets/category_tab.dart';
import 'package:shop_app_clothes/features/shop/screens/store/widgets/category_tab3.dart';
import 'package:shop_app_clothes/features/shop/service/CategoryService.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late Future<List<CategoryResponse>> _categoriesFuture;
  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService.getCategoriesWithProducts();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [TCartCounterIcon(onPressed: () {})],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                backgroundColor:
                    THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSize.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSize.spaceBtwItems),
                      const TSearchContainer(
                        text: "Search in Store",
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.all(TSize.md),
                      ),
                      const SizedBox(height: TSize.spaceBtwSections),

                      // feature brand
                      TSectionHeading(
                        title: "Feature Brands",
                        onPressed: () => Get.to(() => AllProducts()),
                      ),
                      const SizedBox(height: TSize.spaceBtwItems / 1.5),

                      TGridLayout(
                        itemCount: 4, // Display only the first 4 categories
                        mainAxisExtent: 80,
                        itemBuilder: (context, index) {
                          return FutureBuilder<List<CategoryResponse>>(
                            future: _categoriesFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else if (snapshot.hasData) {
                                final categories = snapshot.data!;

                                // Ensure there are at least 4 categories
                                if (index < categories.length) {
                                  final category = categories[index];

                                  return BrandCard(
                                    title: category.name, // Use category name
                                    image: category.image, // Use category image
                                    productCount:
                                        category
                                            .products
                                            .length, // Count of products in the category
                                    onTap: () {
                                      // Handle navigation or actions on tap
                                      print("Tapped on ${category.name}");
                                    },
                                  );
                                } else {
                                  // Return a placeholder if there are less than 4 categories
                                  return const SizedBox();
                                }
                              } else {
                                return const Center(
                                  child: Text('No categories found'),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

                bottom: TTabBar(
                  tabs: [
                    Tab(child: Text("Highest price")),
                    Tab(child: Text("Lowest price")),
                    Tab(child: Text("Most purchased")),
                    Tab(child: Text("highest rated")),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              CategoryTab(),
              CategoryTab2(),
              CategoryTab3(),
              CategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
