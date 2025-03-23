import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/helpers/token_helper.dart';
import '../models/User.dart';
import 'StorageService.dart';
class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080/api/auth',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/token',
        data: {'email': email, 'password': password},
      );

      if (response.data["code"] == 1000 &&
          response.data["result"]["authenticated"] == true) {
        String token = response.data["result"]["token"];

        await StorageService.saveToken(token); // Lưu token vào SharedPreferences

        int? userId = TokenHelper.getUserIdFromToken(token);
        if (userId != null) {
          await StorageService.saveUserId(userId); // Lưu userId
        }

        return User.fromJson(response.data["result"]);
      }
      throw Exception("Invalid email or password");
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }


  // Hàm gửi request có kèm token
  Future<User> getUserInfo(String email) async {
    try {
      String? token = await StorageService.getToken(); // Lấy token từ SharedPreferences
      if (token == null) throw Exception("No token found");

      final response = await _dio.get(
        '/username/$email',
        options: Options(headers: {"Authorization": "Bearer $token"}), // Thêm token vào header
      );

      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }


  // Hàm xử lý lỗi Dio
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
