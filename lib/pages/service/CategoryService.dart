import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app_clothes/pages/models/Category.dart';
import 'StorageService.dart';

class CategoryService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/categories';
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
    return await _dio.get(endpoint,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  Future<List<CategoryResponse>> getAllCategories() async {
    try{
      final response = await _authorizedGetRequest('');
      if(response.data["code"] == 1000 && response.data["result"] != null){
        print(response.data);
        List<dynamic> jsonData = response.data["result"];
        return jsonData.map((data) => CategoryResponse.fromJson(data)).toList();
      }else{
        throw Exception("Failed to fetch categories: Invalid response from server");
      }
    }on DioException catch(e){
      throw Exception(_handleDioError(e));
    }
  }

  Future<CategoryResponse> getCategoryById(int id) async {
    try{
      final response = await _authorizedGetRequest("/search$id");
      if(response.data["code"] == 1000 && response.data["result"] != null){
        return CategoryResponse.fromJson(response.data["result"]);
      }else{
        throw Exception("Failed to fetch category: Invalid response from server");
      }
    }on DioException catch(e){
      throw Exception(_handleDioError(e));
    }
  }

  String  _handleDioError(DioException error){
    switch(error.type){
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
