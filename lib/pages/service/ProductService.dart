import 'package:dio/dio.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';
import 'package:shop_app_clothes/pages/service/StorageService.dart';

class ProductService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/products';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<String?> _getToken() async {
    return await StorageService.getToken();
  }

  Future<Response> _authorizedGetRequest(String endpoint) async {
    String? token = await _getToken();
    if (token == null) throw Exception("No token found");
    return await _dio.get(
      endpoint,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _authorizedGetRequest('/getAlls');
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        List<dynamic> jsonData = response.data["result"];
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception(
          "Failed to fetch products: Invalid response from server",
        );
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<List<Product>> getProductsSortedByPriceDesc() async {
    try {
      final response = await _authorizedGetRequest("/sortedByPrice");
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        List<dynamic> jsonData = response.data["result"];
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception(
          "Failed to fetch products: Invalid response from server",
        );
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<List<Product>> getProductsSortedByPriceAsc() async {
    try {
      final response = await _authorizedGetRequest('/sortedByPriceAsc');
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        List<dynamic> jsonData = response.data["result"];
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception(
          "Failed to fetch products: Invalid response from server",
        );
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<List<Product>> getMostPurchasedProducts() async {
    try {
      final response = await _authorizedGetRequest('/most-purchased');
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        List<dynamic> jsonData = response.data["result"];
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception(
          "Failed to fetch products: Invalid response from server",
        );
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
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
