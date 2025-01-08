class OrderItem {
  final int productId;
  final int quantity;

  OrderItem({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {"productId": productId, "quantity": quantity};
  }
}
