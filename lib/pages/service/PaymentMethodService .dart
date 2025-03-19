import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_clothes/pages/models/PaymentMothod.dart';

class PaymentMethodService {
  final String apiUrl = 'http://10.0.2.2:8080/api/payment-methods';

  Future<List<PaymentMethod>> fetchPaymentMethods() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((item) => PaymentMethod.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load payment methods');
    }
  }
}
