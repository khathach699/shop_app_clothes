import 'dart:convert';

import 'package:http/http.dart' as http;

class THttpClient {
  static const String _baseURL = "";

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse("$_baseURL/$endpoint"));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseURL/$endpoint"),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse("$_baseURL/$endpoint"),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse("$_baseURL/$endpoint"));
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body); // Corrected line
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}
