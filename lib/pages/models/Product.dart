class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String image;
  final String categoryName;
  final List<ColorSize> colorSizes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.categoryName,
    required this.colorSizes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var colorSizesFromJson = json['colorSizes'] as List? ?? [];
    List<ColorSize> colorSizesList = colorSizesFromJson
        .map((colorSize) => ColorSize.fromJson(colorSize))
        .toList();

    return Product(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? json['productName']?.toString() ?? 'Unknown Product',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description']?.toString() ?? 'No description available',
      image: json['image']?.toString() ?? 'path_to_default_image',
      categoryName: json['categoryName']?.toString() ?? 'Unknown Category',
      colorSizes: colorSizesList,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, description: $description, '
        'image: $image, categoryName: $categoryName, colorSizes: $colorSizes)';
  }
}

class ColorSize {
  final String colorName;
  final String sizeName;
  final int quantity;

  ColorSize({
    required this.colorName,
    required this.sizeName,
    required this.quantity,
  });

  factory ColorSize.fromJson(Map<String, dynamic> json) {
    return ColorSize(
      colorName: json['colorName'] ?? 'Unknown Color',
      sizeName: json['sizeName'] ?? 'Unknown Size',
      quantity: json['quantity'] ?? 0,
    );
  }

  @override
  String toString() {
    return '{colorName: $colorName, sizeName: $sizeName, quantity: $quantity}';
  }
}
