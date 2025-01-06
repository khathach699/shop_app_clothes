// lib/http/t_http_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpClient {
  static const String _baseURL =
      "http://localhost:8080/api"; // Ensure URL is correct

  // GET request
  // lib/http/t_http_client.dart
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse("$_baseURL/$endpoint"));
    return _handleResponse(response);
  }

  // POST request
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

  // PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse("$_baseURL/$endpoint"),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    );
    return _handleResponse(response);
  }

  // DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse("$_baseURL/$endpoint"));
    return _handleResponse(response);
  }

  // Handle response from the API
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body); // Decode JSON response
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}
