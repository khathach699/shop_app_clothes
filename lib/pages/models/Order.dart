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

  // Chuyển đổi CartItem sang OrderItem
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
}
