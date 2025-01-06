// lib/common/widgets/products/product_cards/product_card_vertical.dart
import 'package:flutter/material.dart';
import 'package:shop_app_clothes/features/shop/models/Product.dart';
import 'package:shop_app_clothes/features/shop/screens/product_details/product_detail.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TProductCardVertical extends StatelessWidget {
  final Product product;

  const TProductCardVertical({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product: product),
          ),
        );
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image, height: 180, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: TSize.spaceBtwItems / 2),
                  Text(
                    "Category: ${product.categoryName}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: TSize.spaceBtwItems / 2),
                  Text(
                    ' Price: \$${product.price}',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
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
