import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app_clothes/features/shop/models/Comment.dart';

class CommentService {
  static const String apiUrl =
      'http://10.0.2.2:8080/api/comments'; // Replace with your backend URL

  // Get comments for a specific product by ID
  Future<List<Comment>> getComments(int productId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/list?productId=$productId'),
    );

    if (response.statusCode == 200) {
      // Parse the response body and return a list of comments
      List<dynamic> data = json.decode(response.body);
      return data.map((commentJson) => Comment.fromJson(commentJson)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Add a new comment
  Future<Comment> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(comment.toJson()),
    );

    if (response.statusCode == 201) {
      // Parse the response body and return the created comment
      return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add comment');
    }
  }

  // Delete a comment
  Future<void> deleteComment(int commentId, int userId) async {
    final response = await http.delete(
      Uri.parse(
        '$apiUrl/$commentId?userId=$userId',
      ), // Truyền commentId và userId dưới dạng chuỗi
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 204) {
      // Thành công, không có nội dung trả về
      return;
    } else {
      throw Exception('Failed to delete comment');
    }
  }

  // Update a comment
  Future<Comment> updateComment(
    int commentId,
    int userId,
    String newContent,
  ) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$commentId?userId=$userId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'content': newContent}),
    );

    if (response.statusCode == 200) {
      // Parse the response body and return the updated comment
      return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update comment');
    }
  }
}
