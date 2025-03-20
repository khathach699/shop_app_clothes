import 'package:dio/dio.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';

class ProductService {
  static const String _baseURL = 'http://10.0.2.2:8080/api/products';

  // Khởi tạo Dio với cấu hình cơ bản
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseURL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  // Lấy tất cả sản phẩm
  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _dio.get('/getAlls');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Lấy sản phẩm sắp xếp theo giá giảm dần
  Future<List<Product>> getProductsSortedByPriceDesc() async {
    try {
      final response = await _dio.get('/sortedByPrice');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Lấy sản phẩm sắp xếp theo giá tăng dần
  Future<List<Product>> getProductsSortedByPriceAsc() async {
    try {
      final response = await _dio.get('/sortedByPriceAsc');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Lấy sản phẩm được mua nhiều nhất
  Future<List<Product>> getMostPurchasedProducts() async {
    try {
      final response = await _dio.get('/most-purchased');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Hàm xử lý lỗi Dio
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your network.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Unable to send request.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Server took too long to respond.';
      case DioExceptionType.badResponse:
        return 'Server error: ${error.response?.statusCode} - ${error.response?.data}';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        return 'Network error: ${error.message}';
    }
  }
}
