// auth_service.dart
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../models/User.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080/api/auth',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  final GetStorage _storage = GetStorage();
  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/log-in',
        data: {'email': email, 'password': password},
      );

      if (response.data["code"] == 1000 &&
          response.data["result"]["authenticated"] == true) {
        User user = User.fromJson(response.data["result"]);
        await _storage.write("userId", user.id);
        print("User ID saved: ${user.id}");
        return user;
      }
      throw Exception("Invalid email or password");
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<User> getUserInfo(String email) async {
    try {
      final response = await _dio.get('/username/$email');
      return User.fromJson(response.data);
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
