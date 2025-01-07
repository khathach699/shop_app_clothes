class CategoryResponse {
  final int id;
  final String name;
  final String image;
  final List<Product> products;

  CategoryResponse({
    required this.id,
    required this.name,
    required this.image,
    required this.products,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();

    return CategoryResponse(
      id: json['id'] != null ? json['id'].toInt() : 0,
      name: json['name'],
      image: json['image'],
      products: productList,
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String image;
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] != null ? json['id'].toInt() : 0,
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      categoryName: json['categoryName'],
    );
  }
}
