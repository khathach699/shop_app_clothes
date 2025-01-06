import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_clothes/features/shop/models/Product.dart';
import 'dart:io';

class ProductService {
  static const String _baseURL =
      'http://10.0.2.2:8080/api/products'; // Use the correct server URL for your setup

  // Function to get all products from the API
  static Future<List<Product>> getAllProducts() async {
    try {
      final url = '$_baseURL/getAlls';
      print('Making request to: $url'); // Log the request URL for debugging

      final response = await http.get(Uri.parse(url));

      print(
        'Response Status: ${response.statusCode}',
      ); // Log response status code
      print('Response Body: ${response.body}'); // Log the response body

      if (response.statusCode == 200) {
        // If the response is successful (status code 200), decode the body
        List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        // If the status code is not 200, throw an exception
        print('Error: ${response.statusCode}');
        throw Exception('Failed to load products');
      }
    } on SocketException {
      // Handle network-related issues
      print('Network Error: Failed to connect to the network.');
      throw Exception(
        'Failed to connect to the network. Please check your connection.',
      );
    } catch (e) {
      // Catch any other unexpected errors
      print("Unexpected error: $e");
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
