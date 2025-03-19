import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    final url = Uri.parse("http://10.0.2.2:8080/api/orders/add");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Đơn hàng được tạo thành công
      } else {
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }

  Future<List<dynamic>> getOrdersByUserId(int userId) async {
    final url = Uri.parse("http://10.0.2.2:8080/api/orders/user/$userId");

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final body = utf8.decode(
          response.bodyBytes,
        ); // Đảm bảo giải mã đúng UTF-8
        final List<dynamic> orders = jsonDecode(body);
        return orders;
      } else {
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }
}
