class Rating {
  final int? id; // id là nullable khi gửi yêu cầu mới (không có)
  final int userId;
  final int productId;
  final int score;
  final String? createdAt; // createdAt có thể nullable khi gửi yêu cầu mới

  Rating({
    this.id,
    required this.userId,
    required this.productId,
    required this.score,
    this.createdAt,
  });

  // Factory method to create an instance from JSON (Response)
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      score: json['score'],
      createdAt: json['createdAt'],
    );
  }

  // Method to convert the object back to JSON (Request)
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'productId': productId, 'score': score};
  }
}
