import 'package:dio/dio.dart';

import '../models/Cart.dart';
import '../models/CartRequest.dart';
import 'StorageService.dart';

class CartService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/cart';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<String?> _getToken() async {
    return await StorageService.getToken();
  }

  Future<Response> _authorizedRequest(
    String method,
    String endpoint, {
    dynamic data,
  }) async {
    String? token = await _getToken();
    if (token == null) throw Exception("No token found");
    return await _dio.request(
      endpoint,
      data: data,
      options: Options(
        method: method,
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  Future<CartItem?> addToCart(CartRequest cartRequest) async {
    try {
      final response = await _authorizedRequest(
        "POST",
        "/add",
        data: cartRequest.toJson(),
      );
      if (response.data is Map<String, dynamic>) {
        return CartItem.fromJson(response.data);
      }
      throw Exception('Unexpected response format for addToCart');
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<bool> removeFromCart(int cartId) async {
    try {
      final response = await _authorizedRequest("DELETE", "/remove/$cartId");
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<List<CartItem>?> getCart(int userId) async {
    try {
      final response = await _authorizedRequest("GET", "/list/$userId");
      if (response.data is List) {
        return List<CartItem>.from(
          response.data.map((item) => CartItem.fromJson(item)),
        );
      }
      throw Exception('Unexpected response format for getCart');
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioException.connectionTimeout:
        return "Connection timeout";
      case DioException.sendTimeout:
        return "Send timeout";
      case DioException.receiveTimeout:
        return "Receive timeout";
      case DioException.badResponse:
        return "Server error: ${error.response?.statusCode}";
      default:
        return "Network error";
    }
  }
}
