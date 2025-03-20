import 'package:flutter/material.dart';
import 'package:shop_app_clothes/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';
import 'package:shop_app_clothes/pages/service/ProductService.dart';
import 'package:diacritic/diacritic.dart'; // Import diacritic library

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late Future<List<Product>> products;
  List<Product> filteredProducts = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    final productService = ProductService();
    products = productService.getAllProducts(); // Fetch products on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        actions: [
          // Add Search Icon
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(products: filteredProducts),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            // Get product list
            final productList = snapshot.data!;
            filteredProducts = productList; // Update filtered list initially

            return Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return TProductCardVertical(
                        product: product,
                      ); // Pass product to the card
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// Search Delegate Class
class ProductSearchDelegate extends SearchDelegate {
  final List<Product> products;

  ProductSearchDelegate({required this.products});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search field
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter the products based on the query (normalize to diacritic-free text)
    final results =
        products
            .where(
              (product) => removeDiacritics(
                product.name.toLowerCase(),
              ).contains(removeDiacritics(query.toLowerCase())),
            )
            .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return TProductCardVertical(
          product: product,
        ); // Pass filtered product to the card
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions based on query as the user types (normalize to diacritic-free text)
    final suggestions =
        products
            .where(
              (product) => removeDiacritics(
                product.name.toLowerCase(),
              ).contains(removeDiacritics(query.toLowerCase())),
            )
            .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return TProductCardVertical(
          product: product,
        ); // Pass suggestion product to the card
      },
    );
  }
}
