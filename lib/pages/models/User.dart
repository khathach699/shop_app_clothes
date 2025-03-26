import 'package:intl/intl.dart';

class User {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? phone;
  final String? gender;
  final DateTime? dateOfBirth;
  final List<dynamic>? wishlists;
  final List<dynamic>? carts;
  final List<dynamic>? orders;
  final String? message;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.wishlists,
    this.carts,
    this.orders,
    this.message,
  });

  //  nhan api chuyen qua dart
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.tryParse(json['userId'].toString()), // Đổi từ 'id' thành 'userId' vì JSON trả về 'userId'
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      wishlists: json['wishlists'],
      carts: json['carts'],
      orders: json['orders'],
      message: json['message'],
    );
  }

  // dart chuyen api
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'gender': gender,
      'dateOfBirth': dateOfBirth != null
          ? DateFormat('yyyy-MM-dd').format(dateOfBirth!) // Format DateTime thành String
          : null,
      'wishlists': wishlists,
      'carts': carts,
      'orders': orders,
      'message': message,
    };
  }
}
