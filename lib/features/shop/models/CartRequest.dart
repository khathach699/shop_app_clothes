class CartRequest {
  final int userId;
  final int productId;
  final int colorId;
  final int sizeId;
  final int quantity;


  CartRequest({
    required this.userId,
    required this.productId,
    required this.colorId,
    required this.sizeId,
    required this.quantity,
  });

  // Convert a CartRequest object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'colorId': colorId,
      'sizeId': sizeId,
      'quantity': quantity,
    };
  }
}
