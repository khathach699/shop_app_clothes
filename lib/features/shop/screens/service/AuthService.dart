import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/LoginResponse.dart';


class AuthService {
  final String apiUrl = 'http://10.0.2.2:8080/api/auth/login'; // URL API

  Future<LoginResponse> login(String usernameOrEmail, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'usernameOrEmail': usernameOrEmail,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu thành công, trả về LoginResponse
        return LoginResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Login failed');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}
