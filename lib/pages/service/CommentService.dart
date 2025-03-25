import 'dart:convert';
import 'package:dio/dio.dart';
import 'StorageService.dart';
import '../models/Comment.dart';

class CommentService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080/api/comments',
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
    try {
      String? token = await _getToken();
      if (token == null) throw Exception("No token found");
      final options = Options(headers: {"Authorization": "Bearer $token"});
      switch (method) {
        case 'GET':
          return await _dio.get(endpoint, options: options);
        case 'POST':
          return await _dio.post(
            endpoint,
            data: json.encode(data),
            options: options,
          );
        case 'PUT':
          return await _dio.put(
            endpoint,
            data: json.encode(data),
            options: options,
          );
        case 'DELETE':
          return await _dio.delete(endpoint, options: options);
        default:
          throw Exception("Unsupported HTTP method");
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<Comment> addComment(Comment comment) async {
    final response = await _authorizedRequest(
      'POST',
      "",
      data: comment.toJson(),
    );

    if (response.data["code"] == 1000 && response.data["result"] != null) {
      return Comment.fromJson(response.data["result"]);
    } else {
      throw Exception('Failed to add comment');
    }
  }

  Future<List<Comment>> getCommentsByProduct(int productId) async {
    final response = await _authorizedRequest(
      'GET', // ✅ Đảm bảo đang sử dụng phương thức GET
      "/list/$productId",
    );

    if (response.data["code"] == 1000 && response.data["result"] != null) {
      return (response.data["result"] as List)
          .map((json) => Comment.fromJson(json))
          .toList();
    } else {
      throw Exception('🚨 Không thể tải bình luận');
    }
  }

  Future<void> deleteComment(int commentId, int userId) async {
    final response = await _authorizedRequest(
      'DELETE',
      "/$commentId?userId=$userId",
    );

    if (response.statusCode == 200 ||
        (response.data is Map && response.data['code'] == 1000)) {
    } else {
      throw Exception('❌ Xóa thất bại: ${response.statusCode}');
    }
  }

  Future<Comment> updateComment(
    int commentId,
    String newContent,
    int userId,
  ) async {
    final response = await _authorizedRequest(
      'PUT',
      "", //
      data: {"userId": userId, "content": newContent, "id": commentId},
    );

    if (response.data["code"] == 1000 && response.data["result"] != null) {
      return Comment.fromJson(response.data["result"]);
    } else {
      throw Exception('🚨 Cập nhật bình luận thất bại!');
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
