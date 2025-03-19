class WishlistItem {
  final int id;
  final int userId;
  final int productId;
  final String productName;
  final DateTime addedAt;

  WishlistItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.addedAt,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'],
      userId: json['user']['id'],
      productId: json['product']['id'],
      productName: json['product']['name'],
      addedAt: DateTime.parse(json['addedAt']),
    );
  }
}
