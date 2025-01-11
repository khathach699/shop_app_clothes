import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app_clothes/features/shop/models/Category.dart';

class CategoryService {
  static const String _baseURL = 'http://10.0.2.2:8080/api/categories';

  // Function to get all categories with products
  static Future<List<CategoryResponse>> getCategoriesWithProducts() async {
    try {
      final url = '$_baseURL';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((data) => CategoryResponse.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } on SocketException {
      throw Exception(
        'Failed to connect to the network. Please check your connection.',
      );
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Function to get category by ID with products
  static Future<CategoryResponse> getCategoryById(String categoryId) async {
    try {
      final url = '$_baseURL/search/$categoryId'; // Search category by ID
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(
          utf8.decode(response.bodyBytes),
        );
        return CategoryResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load category by ID');
      }
    } on SocketException {
      throw Exception(
        'Failed to connect to the network. Please check your connection.',
      );
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
