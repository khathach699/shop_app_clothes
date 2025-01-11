class CartItem {
  final int cartId;
  final int productId;
  final String productName;
  final String colorName;
  final String sizeName;
  final int quantity;
  final double price;
  final DateTime? addedAt; // Make this field nullable
  final String? productImage; // Add productImage field

  CartItem({
    required this.cartId,
    required this.productId,
    required this.productName,
    required this.colorName,
    required this.sizeName,
    required this.quantity,
    required this.price,
    this.addedAt, // Nullable field
    this.productImage, // Nullable field for product image
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    print(
      'Parsing CartItem: $json',
    ); // Add this to see what data is being parsed
    return CartItem(
      cartId: json['cartId'],
      productId: json['productId'],
      productName: json['productName'],
      colorName: json['colorName'],
      sizeName: json['sizeName'],
      quantity: json['quantity'],
      price: json['price'],
      addedAt:
          json['addedAt'] != null
              ? DateTime.parse(json['addedAt'])
              : null, // Check if the field exists and is in the correct format
      productImage: json['productImage'], // Parse productImage from response
    );
  }

  get imageUrl => null;

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    'productId': productId,
    'productName': productName,
    'colorName': colorName,
    'sizeName': sizeName,
    'quantity': quantity,
    'price': price,
    'addedAt': addedAt?.toIso8601String(), // Handle nullable `addedAt`
    'productImage': productImage, // Include productImage in the JSON
  };
}
