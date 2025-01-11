class OrderItem {
  final int productId;
  final int quantity;
  final int? colorId;
  final int? sizeId;
  final String? productName;
  final double? priceAtOrder;

  OrderItem({
    required this.productId,
    required this.quantity,
    this.colorId,
    this.sizeId,
    this.productName,
    this.priceAtOrder,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "quantity": quantity,
      "colorId": colorId,
      "sizeId": sizeId,
      "productName": productName,
      "priceAtOrder": priceAtOrder,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
      colorId: json['colorId'] as int?,
      sizeId: json['sizeId'] as int?,
      productName: json['productName'] as String?,
      priceAtOrder: json['priceAtOrder'] as double?,
    );
  }
}
