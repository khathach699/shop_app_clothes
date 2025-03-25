import 'package:dio/dio.dart';

import 'StorageService.dart';

class OrderService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/orders';
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

  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _authorizedRequest(
        "POST",
        "/add",
        data: orderData,
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<List<dynamic>> getOrdersByUserId(int userId) async {
    try {
      final response = await _authorizedRequest("GET", "/user/$userId");
      if (response.data is List) {
        return response.data;
      }
      throw Exception('Unexpected response format for getOrdersByUserId');
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
        return "Server error: \${error.response?.statusCode}";
      default:
        return "Network error";
    }
  }
}
