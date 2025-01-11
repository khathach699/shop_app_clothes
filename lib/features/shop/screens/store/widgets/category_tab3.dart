import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/brands/brands_show_case.dart';
import 'package:shop_app_clothes/common/widgets/layouts/grid_layout.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/service/ProductService.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/features/shop/models/Product.dart'; // Assuming you have a Product model
// Assuming you have a service to fetch products

class CategoryTab3 extends StatefulWidget {
  const CategoryTab3({super.key});

  @override
  _CategoryTab3State createState() => _CategoryTab3State();
}

class _CategoryTab3State extends State<CategoryTab3> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    // Fetch products sorted by price descending initially
    _products = ProductService.getMostPurchasedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              // Display the first 3 product images dynamically
              FutureBuilder<List<Product>>(
                future: _products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No products available.'));
                  } else {
                    // Extract images of the first 3 products
                    List<Product> products = snapshot.data!;
                    List<String> images =
                        products
                            .take(3)
                            .map((product) => product.image)
                            .toList();

                    return TBrandShowcase(
                      images: images, // Pass the images list dynamically
                    );
                  }
                },
              ),
              TSectionHeading(
                title: "You might like",
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              // Display products grid
              FutureBuilder<List<Product>>(
                future: _products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No products available.'));
                  } else {
                    List<Product> products = snapshot.data!;
                    return TGridLayout(
                      itemCount: products.length,
                      itemBuilder:
                          (_, index) =>
                              TProductCardVertical(product: products[index]),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
