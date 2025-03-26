import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shop_app_clothes/pages/models/PaymentMothod.dart';

import 'StorageService.dart';

class PaymentMethodService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/payment-methods';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<String?> _getToken () async => await StorageService.getToken();
  Future<Response> _authenticateUser(
      String method,
      String endpoint, {
        dynamic data
      }) async {
    try{
      String? token = await _getToken();
      if(token == null) throw Exception("No token found");
      final options = Options(headers: {"Authorization": "Bearer $token"});
      switch(method){
        case 'GET':
          return await _dio.get(endpoint, options: options);
        case 'PUT':
          return await _dio.put(endpoint, data: json.encode(data), options: options);
        default:
          throw Exception("Unsupported HTTP method");
      }
    }on DioException catch(e){
      throw Exception(_handleDioError(e));
    }
  }



  Future<List<PaymentMethod>> fetchPaymentMethods() async {
    final response = await _authenticateUser("GET", "");
    if(response.data["code"] == 1000|| response.data["result"] != null){
      return (response.data["result"] as List)
          .map((data) => PaymentMethod.fromJson(data))
          .toList();
    }else{
      throw Exception("Failed to fetch payment methods: Invalid response from server");
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
