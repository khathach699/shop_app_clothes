import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_clothes/pages/models/Product.dart';
import 'dart:io';

class ProductService {
  static const String _baseURL =
      'http://10.0.2.2:8080/api/products'; // Use the correct server URL for your setup
  static Future<List<Product>> getAllProducts() async {
    try {
      final url = '$_baseURL/getAlls';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on SocketException {
      throw Exception(
        'Failed to connect to the network. Please check your connection.',
      );
    } catch (e) {
      // Catch any other unexpected errors

      throw Exception('An unexpected error occurred: $e');
    }
  }

  static Future<List<Product>> getProductsSortedByPriceDesc() async {
    try {
      final url =
          '$_baseURL/sortedByPrice'; // Call the endpoint for descending price
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on SocketException {
      throw Exception(
        'Failed to connect to the network. Please check your connection.',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Get products sorted by price in ascending order
  static Future<List<Product>> getProductsSortedByPriceAsc() async {
    try {
      final url =
          '$_baseURL/sortedByPriceAsc'; // Call the endpoint for ascending price
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on SocketException {
      throw Exception(
        'Failed to connect to the network. Please check your connection.',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  static Future<List<Product>> getMostPurchasedProducts() async {
    try {
      final url =
          '$_baseURL/most-purchased'; // Call the endpoint for ascending price
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on SocketException {
      throw Exception(
        'Failed to connect to the network. Please check your connection.',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
