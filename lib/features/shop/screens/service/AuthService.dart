import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/User.dart';


class AuthService {
  final String apiUrl = 'http://10.0.2.2:8080/api/auth/login'; // URL API

  Future<User> login(String usernameOrEmail, String password) async {
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
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Login failed');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
  // get info user by user
  Future<User> getUserInfoByUsernameOrEmail(String usernameOrEmail) async{
    final String userApiUrl = 'http://10.0.2.2:8080/api/auth/username/$usernameOrEmail';

    try {
      final response = await http.get(Uri.parse(userApiUrl));
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch user info');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}


