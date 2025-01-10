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
  final List<ProductColorSize> colorSizes; // Add the colorSizes field

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.categoryName,
    required this.colorSizes, // Initialize colorSizes
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var colorSizeList = json['colorSizes'] as List;
    List<ProductColorSize> colorSizes =
        colorSizeList.map((i) => ProductColorSize.fromJson(i)).toList();

    return Product(
      id: json['id'] != null ? json['id'].toInt() : 0,
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      categoryName: json['categoryName'],
      colorSizes: colorSizes, // Parse the colorSizes field
    );
  }
}

class ProductColorSize {
  final String colorName;
  final String sizeName;
  final int quantity;

  ProductColorSize({
    required this.colorName,
    required this.sizeName,
    required this.quantity,
  });

  factory ProductColorSize.fromJson(Map<String, dynamic> json) {
    return ProductColorSize(
      colorName: json['colorName'],
      sizeName: json['sizeName'],
      quantity: json['quantity'],
    );
  }
}
