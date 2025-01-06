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
    var colorSizesFromJson = json['colorSizes'] as List;
    List<ColorSize> colorSizesList =
        colorSizesFromJson
            .map((colorSize) => ColorSize.fromJson(colorSize))
            .toList();

    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      categoryName: json['categoryName'],
      colorSizes: colorSizesList,
    );
  }

  // Static method for a default product
  static Product defaultProduct() {
    return Product(
      id: 0,
      name: 'Default Product',
      price: 0.0,
      description: 'This is a default product description.',
      image: 'path_to_default_image', // Put a default image path or placeholder
      categoryName: 'Default Category',
      colorSizes: [
        ColorSize(colorName: 'Default Color', sizeName: 'M', quantity: 0),
      ],
    );
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
      colorName: json['colorName'],
      sizeName: json['sizeName'],
      quantity: json['quantity'],
    );
  }
}
