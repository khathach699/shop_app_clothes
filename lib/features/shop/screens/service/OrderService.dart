import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  static const String _baseUrl = "http://10.0.2.2:8080/api/orders";

  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    final url = Uri.parse("$_baseUrl/add");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Đơn hàng được tạo thành công
      } else {
        print("Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
