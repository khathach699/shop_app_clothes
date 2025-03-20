import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/Product.dart';

class WishListService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080/api/wishlist',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    )
  );

  Future<List<Product>> getWishlist(int userId) async {
    try {
      final response = await _dio.post("/listWishlist", data: {"id": userId});

      if (response.data["code"] == 1000 && response.data["result"] != null) {
        if (response.data["result"] is List) {
          return response.data["result"]
              .map<Product>((item) => Product.fromJson(item))
              .toList();
        } else {
          throw Exception("Invalid data format for wishlist");
        }
      } else {
        throw Exception("Failed to fetch wishlist: ${response.data}");
      }
    } on DioException catch (e) {
      throw Exception("Request failed: ${e.response?.data ?? e.message}");
    } catch (e, stackTrace) {
      throw Exception("Unhandled error: $e");
    }
  }


  Future<void> addProductToWishlist(int userId, int productId) async {
    try{
      final response = await _dio.post("/add",
        data: {"id": userId, "productId": productId}
      );
      if(response.data["code"] == 1000 && response.data["result"] != null){
        print("Product added to wishlist");
      }else{
        throw Exception("Failed to add product to wishlist");
      }
    }on DioException catch(e){
      _handleDioError(e);
    }catch(e){
      throw Exception("Error adding product to wishlist: $e");
    }
  }

  Future<void> removeProductFromWishlist(int userId, int productId) async {
    try{
      final response = await _dio.delete("/",
        data: {"id": userId, "productId": productId}
      );
      if(response.data["code"] == 1000 && response.data["result"] == "wishlist removed"){
        print("Product removed from wishlist");
      }else{
        throw Exception("Failed to remove product from wishlist");
      }
      }on DioException catch(e){
      _handleDioError(e);
    }catch(e){
      throw Exception("Error removing product from wishlist: $e");
    }
  }

  Future<bool> isProductInWishlist(int userId, int productId) async {
    final response = await _dio.get("/exists",
        data: {"id": userId, "productId": productId}
    );
    try {
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        return response.data["result"];
      } else {
        throw Exception("Failed to check if product is in wishlist");
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return false;
    } catch (e) {
      throw Exception("Error checking if product is in wishlist: $e");
    }
  }


   String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.sendTimeout:
        return "Send timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout";
      case DioExceptionType.badResponse:
        return "Server error: ${error.response?.statusCode}";
      default:
        return "Network error";
    }
  }


}

//
// class WishListService {
//
//   static const String baseUrl = "http://10.0.2.2:8080/api/wishlist";
//
//   // Get wishlist of a user
//   static Future<List<Product>> getWishlist(int userId) async {
//     try {
//       final response = await http.get(Uri.parse("$baseUrl/$userId"));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(utf8.decode(response.bodyBytes));
//         if (data is List) {
//           return data.map((item) => Product.fromJson(item)).toList();
//         } else {
//           throw Exception("Invalid data format: Expected a list.");
//         }
//       } else {
//         throw Exception("Failed to load wishlist: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Error fetching wishlist: $e");
//     }
//   }
//
//   // Add product to wishlist
//   static Future<void> addProductToWishlist(int userId, int productId) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/$userId/add/$productId'),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         print('Product added to wishlist');
//       } else {
//         throw Exception('Failed to add product to wishlist');
//       }
//     } catch (e) {
//       throw Exception('Error adding product to wishlist: $e');
//     }
//   }
//
//   // Remove product from wishlist
//   static Future<void> removeProductFromWishlist(
//     int userId,
//     int productId,
//   ) async {
//     try {
//       final response = await http.delete(
//         Uri.parse('$baseUrl/$userId/remove/$productId'),
//       );
//
//       if (response.statusCode == 200) {
//         print('Product removed from wishlist');
//       } else {
//         throw Exception('Failed to remove product from wishlist');
//       }
//     } catch (e) {
//       throw Exception('Error removing product from wishlist: $e');
//     }
//   }
//
//   // Check if product is in wishlist
//   static Future<bool> isProductInWishlist(int userId, int productId) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/$userId/exists/$productId'),
//     );
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data; // Trả về true hoặc false từ API
//     } else {
//       throw Exception('Failed to check if product is in wishlist');
//     }
//   }
// }
