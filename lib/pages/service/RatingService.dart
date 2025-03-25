import 'dart:convert';
import 'package:dio/dio.dart';
import 'StorageService.dart';
import '../models/Rating.dart';

class RatingService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080/api/ratings',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<String?> _getToken() async => await StorageService.getToken();

  Future<Response> _authorizedRequest(
    String method,
    String endpoint, {
    dynamic data,
  }) async {
    try {
      String? token = await _getToken();
      if (token == null) throw Exception("No token found");

      final options = Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      switch (method) {
        case 'GET':
          return await _dio.get(endpoint, options: options);
        case 'POST':
          return await _dio.post(
            endpoint,
            data: jsonEncode(data),
            options: options,
          );
        default:
          throw Exception("Unsupported HTTP method");
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<Rating> addRating(Rating rating) async {
    try {
      final response = await _authorizedRequest(
        'POST',
        "",
        data: rating.toJson(),
      );
      if (response.data["code"] == 1000 && response.data["result"] != null) {
        return Rating.fromJson(response.data["result"]);
      } else {
        throw Exception(
          'Failed to add rating: ${response.data["message"] ?? "Unknown error"}',
        );
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${_handleDioError(e)}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<double> getAverageRating(int productId) async {
    final response = await _authorizedRequest('GET', "/average/$productId");
    if (response.data["code"] == 1000 && response.data["result"] != null) {
      return double.tryParse(response.data["result"].toString()) ?? 0.0;
    } else {
      throw Exception('Failed to load average rating');
    }
  }

  Future<Map<String, int>> getRatingsDistribution(int productId) async {
    final response = await _authorizedRequest('GET', "/$productId");
    if (response.data["code"] == 1000 && response.data["result"] is List) {
      Map<String, int> ratingDistribution = {
        '5': 0,
        '4': 0,
        '3': 0,
        '2': 0,
        '1': 0,
      };

      for (var rating in response.data["result"]) {
        int score = rating['score'];
        String key = score.toString();
        if (ratingDistribution.containsKey(key)) {
          ratingDistribution[key] = ratingDistribution[key]! + 1;
        }
      }
      return ratingDistribution;
    } else {
      throw Exception('Failed to load rating distribution');
    }
  }

  Future<int> getTotalRatings(int productId) async {
    final response = await _authorizedRequest('GET', "/$productId");
    if (response.data["code"] == 1000 && response.data["result"] is List) {
      return (response.data["result"] as List).length;
    } else {
      throw Exception('Failed to load total ratings');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout";
      case DioExceptionType.badResponse:
        return "Server error: ${error.response?.statusCode}";
      default:
        return "Network error";
    }
  }
}
