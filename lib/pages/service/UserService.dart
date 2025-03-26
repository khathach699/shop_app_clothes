import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/User.dart';
import 'StorageService.dart';

class UserService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<User> createUser(
    String username,
    String password,
    String email,
  ) async {
    try {
      final response = await _dio.post(
        "/users",
        data: {'username': username, 'password': password, 'email': email},
      );

      if (response.data["code"] == 1000 && response.data["result"] != null) {
        return User.fromJson(response.data["result"]);
      } else {
        throw Exception("Failed to create user: Invalid response from server");
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception("Create failed: $e");
    }
  }

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

  Future<User> getUserById(int userId) async {
    try {
      final response = await _authenticateUser(
        'GET',
        "/users/$userId",
      );
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        return User.fromJson(response.data["result"]);
      } else {
        throw Exception("Failed to get user: Invalid response from server");
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
  Future<User> updateUser(int userId, Map<String, dynamic> updatedData) async {
    try {
      final response = await _authenticateUser(
        'PUT',
        "/users/$userId",
        data: updatedData,
      );
      print(response.data);
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        return User.fromJson(response.data["result"]);
      } else {
        throw Exception("Failed to update user: Invalid response from server");
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception("Update failed: $e");
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
