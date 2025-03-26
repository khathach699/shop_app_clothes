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
      productId: json['productId'] ?? 0,
      productName: json['productName']?.toString(),
      quantity: json['quantity'] ?? 0,
      priceAtOrder: json['priceAtOrder'] != null ? (json['priceAtOrder'] as num).toDouble() : 0.0,
      colorId: json['colorId'] as int?,
      sizeId: json['sizeId'] as int?,
      // Chống lỗi null
    );
  }


}
