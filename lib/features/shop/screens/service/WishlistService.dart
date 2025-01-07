
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_clothes/features/shop/models/WishlistItem.dart';


class WishListService {
  static const String baseUrl = "http://10.0.2.2:8080/api/wishlist";

  //get wishlist
  static Future<List<WishlistItem>> getWishlist(int userId) async {
    try{
      final response = await http.get(Uri.parse("$baseUrl/$userId"));
      if(response.statusCode == 200){
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => WishlistItem.fromJson(item)).toList();
      }else{
        throw Exception("Faild to load wishlist");
      }
    }catch(e) {
      throw Exception("Error e");
    }
  }

  // add wishlist

  static Future<void> addProductToWishlist(int userId, int productId) async {
    try{
      final response = await http.post(Uri.parse('$baseUrl/$userId/add/$productId'));
      if(response.statusCode != 200){
        throw Exception('Failed to add product to wishlist');
      }
    }catch(e) {
      throw Exception("Error e");
    }
  }

  // Xóa sản phẩm khỏi Wishlist
  static Future<void> removeProductFromWishlist(int userId, int productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$userId/remove/$productId'),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to remove product from wishlist');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
