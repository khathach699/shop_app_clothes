import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_clothes/features/shop/models/Rating.dart';

class RatingService {
  final String baseUrl = 'http://10.0.2.2:8080/api/ratings';

  // Thêm một đánh giá mới (POST)
  Future<Rating> addRating(Rating rating) async {
    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(rating.toJson()),
    );

    if (response.statusCode == 200) {
      return Rating.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add rating');
    }
  }

  // Lấy danh sách đánh giá cho sản phẩm (GET)
  Future<List<Rating>> getRatingsByProduct(int productId) async {
    final url = Uri.parse('$baseUrl/$productId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((ratingJson) => Rating.fromJson(ratingJson)).toList();
    } else {
      throw Exception('Failed to load ratings');
    }
  }

  // Lấy phân phối số lượng đánh giá cho mỗi mức sao (GET)
  Future<Map<String, int>> getRatingsDistribution(int productId) async {
    final url = Uri.parse('$baseUrl/$productId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Tính số lượng đánh giá cho mỗi mức sao
      Map<String, int> ratingDistribution = {
        '5': 0,
        '4': 0,
        '3': 0,
        '2': 0,
        '1': 0,
      };

      for (var rating in data) {
        int score = rating['score'];
        if (ratingDistribution.containsKey(score.toString())) {
          ratingDistribution[score.toString()] =
              ratingDistribution[score.toString()]! + 1;
        }
      }

      return ratingDistribution;
    } else {
      throw Exception('Failed to load rating distribution');
    }
  }

  // Lấy điểm trung bình đánh giá cho sản phẩm (GET)
  Future<double> getAverageRating(int productId) async {
    final url = Uri.parse('$baseUrl/average/$productId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return double.parse(response.body); // Chuyển đổi từ string sang double
    } else {
      throw Exception('Failed to load average rating');
    }
  }

  Future<int> getTotalRatings(int productId) async {
    final url = Uri.parse('$baseUrl/$productId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.length; // Trả về số lượng đánh giá
    } else {
      throw Exception('Failed to load total ratings');
    }
  }
}
