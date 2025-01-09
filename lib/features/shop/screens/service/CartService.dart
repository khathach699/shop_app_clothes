import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/Cart.dart';
import '../../models/CartRequest.dart';

class CartService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/cart';

  // Handle the response and decode it safely into List<dynamic>
  Future<dynamic> _handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      try {
        // Try to decode the response as JSON and check if it's a List or Map
        var decodedResponse = json.decode(utf8.decode(response.bodyBytes));

        // If it's a List<dynamic>, return it
        if (decodedResponse is List) {
          return decodedResponse;
        }

        // If it's a Map, return the map
        if (decodedResponse is Map) {
          return decodedResponse;
        }

        // If it's neither, throw an error
        throw Exception('Unexpected response format');
      } catch (e) {
        throw Exception('Error decoding response: $e');
      }
    } else {
      // Server error response
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  // Add an item to the cart
  Future<CartItem?> addToCart(CartRequest cartRequest) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cartRequest.toJson()),
      );

      final data = await _handleResponse(response);

      // If the response is a map, directly map it to a CartItem
      if (data is Map<String, dynamic>) {
        return CartItem.fromJson(data);
      }

      // If the response is a list, handle it accordingly
      throw Exception('Unexpected response format for addToCart');
    } catch (e) {
      print('Error adding product to cart: $e');
      rethrow;
    }
  }

  // Remove an item from the cart by its ID
  Future<bool> removeFromCart(int cartId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/remove/$cartId'));
      // Kiểm tra nếu phản hồi là 200 (thành công)
      if (response.statusCode == 200) {
        return true;
      } else {
        // Trường hợp có lỗi từ server
        print('Error removing product from cart: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error removing product from cart: $e');
      return false;
    }
  }

  // Get the cart for a specific user
  Future<List<CartItem>?> getCart(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/list/$userId'));
      print('Response body: ${response.body}'); // Debugging print

      final data = await _handleResponse(
        response,
      ); // Now `data` will be a List<dynamic>
      print('Parsed Data: $data'); // Debugging print to see the parsed data

      // Map each item in the list to a CartItem object
      return List<CartItem>.from(data.map((item) => CartItem.fromJson(item)));
    } catch (e) {
      print('Error fetching cart: $e');
      return null;
    }
  }
}
