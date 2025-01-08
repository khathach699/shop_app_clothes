import 'package:shop_app_clothes/features/shop/models/OrderItem.dart';

class Order {
  final int userId;
  final int paymentMethodId;
  final String userName;
  final String address;
  final String phoneNumber;
  final List<OrderItem> orderItems;

  Order({
    required this.userId,
    required this.paymentMethodId,
    required this.userName,
    required this.address,
    required this.phoneNumber,
    required this.orderItems,
  });

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
