import 'package:dio/dio.dart';
import 'package:shop_app_clothes/pages/models/PaymentMothod.dart';

class PaymentMethodService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/payment-methods';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<List<PaymentMethod>> fetchPaymentMethods() async {
    try {
      final response = await _dio.get("/");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => PaymentMethod.fromJson(item)).toList();
      }
      throw Exception('Failed to load payment methods');
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
