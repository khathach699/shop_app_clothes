class Comment {
  final int id;
  final int productId;
  final int userId;
  final String username;
  late final String content;
  final DateTime timestamp;
  final int? parentCommentId;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.productId,
    required this.userId,
    required this.username,
    required this.content,
    required this.timestamp,
    this.parentCommentId,
    this.replies = const [],
  });

  // Factory method to create a Comment object from JSON
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      productId: json['productId'],
      userId: json['userId'],
      username: json['username'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      parentCommentId: json['parentCommentId'],
      replies:
          (json['replies'] as List).map((e) => Comment.fromJson(e)).toList(),
    );
  }

  // Convert Comment object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'username': username,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'parentCommentId': parentCommentId,
      'replies': replies.map((e) => e.toJson()).toList(),
    };
  }
}
