import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Product.dart';

class WishListService {
  static const String baseUrl = "http://10.0.2.2:8080/api/wishlist";
  static const Map<String, String> headers = {'Content-Type': 'application/json'};

  // Lấy danh sách wishlist của người dùng
  static Future<List<Product>> getWishlist(int userId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$userId"));

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        if (data is List) {
          return data.map((item) => Product.fromJson(item)).toList();
        } else {
          throw Exception("Dữ liệu trả về không đúng định dạng.");
        }
      } else {
        throw Exception("Không thể tải danh sách wishlist: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Lỗi khi lấy danh sách wishlist: $e");
    }
  }

  // Thêm sản phẩm vào wishlist
  static Future<void> addProductToWishlist(int userId, int productId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$userId/add/$productId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Sản phẩm đã được thêm vào wishlist.');
      } else {
        throw Exception('Không thể thêm sản phẩm vào wishlist.');
      }
    } catch (e) {
      throw Exception('Lỗi khi thêm sản phẩm vào wishlist: $e');
    }
  }

  // Xóa sản phẩm khỏi wishlist
  static Future<void> removeProductFromWishlist(int userId, int productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$userId/remove/$productId'),
      );

      if (response.statusCode == 200) {
        print('Sản phẩm đã bị xóa khỏi wishlist.');
      } else {
        throw Exception('Không thể xóa sản phẩm khỏi wishlist.');
      }
    } catch (e) {
      throw Exception('Lỗi khi xóa sản phẩm khỏi wishlist: $e');
    }
  }

  // Kiểm tra sản phẩm có trong wishlist hay không
  static Future<bool> isProductInWishlist(int userId, int productId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$userId/exists/$productId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is bool) {
          return data;
        } else {
          throw Exception("Dữ liệu trả về không đúng định dạng.");
        }
      } else {
        throw Exception('Không thể kiểm tra sản phẩm trong wishlist.');
      }
    } catch (e) {
      throw Exception('Lỗi khi kiểm tra sản phẩm trong wishlist: $e');
    }
  }
}
