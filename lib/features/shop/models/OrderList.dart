import 'package:shop_app_clothes/features/shop/models/OrderItem.dart';

class OrderList {
  final int orderId; // Thêm thuộc tính orderId
  final int userId;
  // final int paymentMethodId;
  final String userName;
  final String address;
  final String phoneNumber;
  final double totalPrice; // Thêm thuộc tính totalPrice
  final String status; // Thêm thuộc tính status
  final String createdAt; // Thêm thuộc tính createdAt
  final String paymentMethodName; // Thêm thuộc tính paymentMethodName
  final String paymentStatus; // Thêm thuộc tính paymentStatus
  final List<OrderItem> orderItems;

  OrderList({
    required this.orderId,
    required this.userId,
    // required this.paymentMethodId,
    required this.userName,
    required this.address,
    required this.phoneNumber,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.paymentMethodName,
    required this.paymentStatus,
    required this.orderItems,
  });

  // Chuyển đổi CartItem sang OrderItem, các thuộc tính bổ sung sẽ được gán giá trị mặc định
  static OrderList fromCartItems(
    int userId,
    int paymentMethodId,
    String userName,
    String address,
    String phoneNumber,
    List<OrderItem> cartItems,
  ) {
    List<OrderItem> orderItems =
        cartItems.map((cartItem) {
          return OrderItem(
            productId: cartItem.productId,
            quantity: cartItem.quantity,
          );
        }).toList();

    return OrderList(
      orderId: 0, // Giá trị mặc định
      userId: userId,
      // paymentMethodId: paymentMethodId,
      userName: userName,
      address: address,
      phoneNumber: phoneNumber,
      totalPrice: 0.0, // Giá trị mặc định
      status: "PENDING", // Giá trị mặc định
      createdAt: DateTime.now().toIso8601String(), // Giá trị hiện tại
      paymentMethodName: "", // Giá trị mặc định
      paymentStatus: "Pending", // Giá trị mặc định
      orderItems: orderItems,
    );
  }

  // Factory method để tạo Order từ JSON
  factory OrderList.fromJson(Map<String, dynamic> json) {
    try {
      return OrderList(
        orderId: json['orderId'],
        userId: json['userId'],
        // paymentMethodId: json['paymentMethodId'],
        userName: json['userName'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
        totalPrice: json['totalPrice'],
        status: json['status'],
        createdAt: json['createdAt'],
        paymentMethodName: json['paymentMethodName'],
        paymentStatus: json['paymentStatus'],
        orderItems:
            (json['orderItems'] as List<dynamic>)
                .map((item) => OrderItem.fromJson(item))
                .toList(),
      );
    } catch (e) {
      print("Error in Order.fromJson: $e");
      rethrow; // Bắn lỗi để debug
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "userId": userId,
      // "paymentMethodId": paymentMethodId,
      "userName": userName,
      "address": address,
      "phoneNumber": phoneNumber,
      "totalPrice": totalPrice,
      "status": status,
      "createdAt": createdAt,
      "paymentMethodName": paymentMethodName,
      "paymentStatus": paymentStatus,
      "orderItems": orderItems.map((item) => item.toJson()).toList(),
    };
  }
}
