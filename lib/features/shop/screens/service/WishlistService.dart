import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/Product.dart';

class WishListService {
  // 10.0.2.2
  //192.168.100.12:8080
  static const String baseUrl = "http://10.0.2.2:8080/api/wishlist";

  // Get wishlist of a user
  static Future<List<Product>> getWishlist(int userId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$userId"));

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        if (data is List) {
          return data.map((item) => Product.fromJson(item)).toList();
        } else {
          throw Exception("Invalid data format: Expected a list.");
        }
      } else {
        throw Exception("Failed to load wishlist: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching wishlist: $e");
    }
  }

  // Add product to wishlist
  static Future<void> addProductToWishlist(int userId, int productId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$userId/add/$productId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Product added to wishlist');
      } else {
        throw Exception('Failed to add product to wishlist');
      }
    } catch (e) {
      throw Exception('Error adding product to wishlist: $e');
    }
  }

  // Remove product from wishlist
  static Future<void> removeProductFromWishlist(
    int userId,
    int productId,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$userId/remove/$productId'),
      );

      if (response.statusCode == 200) {
        print('Product removed from wishlist');
      } else {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Error removing product from wishlist: $e');
    }
  }

  // Check if product is in wishlist
  static Future<bool> isProductInWishlist(int userId, int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$userId/exists/$productId'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Trả về true hoặc false từ API
    } else {
      throw Exception('Failed to check if product is in wishlist');
    }
  }
}
