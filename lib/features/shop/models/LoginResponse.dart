class LoginResponse {
  final String? message;
  final String? username;

  LoginResponse({this.message, this.username});

  // Phương thức để chuyển đổi từ JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      username: json['username'],
    );
  }

  // Phương thức để chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'username': username,
    };
  }
}
