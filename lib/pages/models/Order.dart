import 'package:shop_app_clothes/pages/models/OrderItem.dart';

class Order {
  final int userId;
  final int paymentMethodId;
  final String userName;
  final String address;
  final String phoneNumber;
  final List<OrderItem> orderItems; // Sử dụng OrderItem

  Order({
    required this.userId,
    required this.paymentMethodId,
    required this.userName,
    required this.address,
    required this.phoneNumber,
    required this.orderItems,
  });


  static Order fromCartItems(
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
            colorId: cartItem.colorId, // Ensure cartItem has colorId
            sizeId: cartItem.sizeId,
            productName: cartItem.productName,
            priceAtOrder: cartItem.priceAtOrder,
            // Ensure cartItem has sizeId
          );
        }).toList();

    return Order(
      userId: userId,
      paymentMethodId: paymentMethodId,
      userName: userName,
      address: address,
      phoneNumber: phoneNumber,
      orderItems: orderItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "paymentMethodId": paymentMethodId,
      "userName": userName,
      "address": address,
      "phoneNumber": phoneNumber,
      "orderItems": orderItems.map((item) => item.toJson()).toList(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    try {
      return Order(
        userId: json["userId"] ?? 0,
        paymentMethodId: json["paymentMethodId"] != null ? json["paymentMethodId"] as int : 0,
        userName: json["userName"]?.toString() ?? "Unknown",
        address: json["address"]?.toString() ?? "No address",
        phoneNumber: json["phoneNumber"]?.toString() ?? "No phone",
        orderItems: (json["orderItems"] as List?)
            ?.map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
            .toList() ??
            [],
      );
    } catch (e) {
      print("Error in Order.fromJson: $e");
      throw Exception("Error parsing Order JSON");
    }
  }





}
