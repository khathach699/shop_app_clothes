class User  {

  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final List<dynamic>? wishlists; // Có thể thay đổi kiểu cho phù hợp (e.g., List<Wishlist>)
  final List<dynamic>? carts;     // Có thể thay đổi kiểu cho phù hợp (e.g., List<Cart>)
  final List<dynamic>? orders;
  final String? message;// Có thể thay đổi kiểu cho phù hợp (e.g., List<Order>)

  User ({
    this.id,
    this.username,
    this.email,
    this.password,
    this.wishlists,
    this.carts,
    this.orders,
    this.message
  });

  // Phương thức để chuyển đổi từ JSON
  factory User .fromJson(Map<String, dynamic> json) {
    return User (
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      wishlists: json['wishlists'], // Cần map từng phần tử nếu `wishlists` là danh sách object
      carts: json['carts'],         // Cần map tương tự như trên
      orders: json['orders'],
      message: json['message'],// Cần map tương tự
    );
  }

  // Phương thức để chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'wishlists': wishlists, // Nếu cần map lại từng phần tử, thực hiện tương tự như `toJson`
      'carts': carts,
      'orders': orders,
      "message": message,
    };
  }
}
