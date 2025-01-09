import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    final url = Uri.parse("http://10.0.2.2:8080/api/orders/add");

    try {
      print("Sending order data: ${jsonEncode(orderData)}");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

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
}
