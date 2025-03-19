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
    // Handling 'colorSizes' gracefully with a fallback to an empty list if null or missing
    var colorSizesFromJson = json['colorSizes'] as List? ?? [];
    List<ColorSize> colorSizesList = colorSizesFromJson
        .map((colorSize) => ColorSize.fromJson(colorSize))
        .toList();

    // Returning the Product object with null safety checks
    return Product(
      id: json['id'] ?? 0, // Default to 0 if null
      name: json['name']?.toString() ?? json['productName']?.toString() ?? 'Unknown Product', // Default if null or missing
      price: (json['price'] != null && json['price'] is num)
          ? (json['price'] as num).toDouble()
          : (json['price'] != null && json['price'] is String)
          ? double.tryParse(json['price']) ?? 0.0
          : 0.0, // Default to 0.0 if null or invalid type
      description: json['description']?.toString() ?? 'No description available', // Default if null
      image: json['image']?.toString() ?? 'path_to_default_image', // Default if null
      categoryName: json['categoryName']?.toString() ?? 'Unknown Category', // Default if null
      colorSizes: colorSizesList, // Safely handle the 'colorSizes' list
    );
  }



  // factory Product.fromJson(Map<String, dynamic> json) {
  //   var colorSizesFromJson = json['colorSizes'] as List;
  //   List<ColorSize> colorSizesList =
  //   colorSizesFromJson
  //       .map((colorSize) => ColorSize.fromJson(colorSize))
  //       .toList();
  //
  //   return Product(
  //     id: json['id'],
  //     name: json['name'],
  //     price: json['price'],
  //     description: json['description'],
  //     image: json['image'],
  //     categoryName: json['categoryName'],
  //     colorSizes: colorSizesList,
  //   );
  // }



  // factory Product.fromJson(Map<String, dynamic> json) {
  //   // Ensure that each field is properly checked and provided a default value if null
  //
  //   // Handling colorSizes with a fallback empty list
  //   var colorSizesFromJson = json['colorSizes'] as List? ?? [];
  //   List<ColorSize> colorSizesList = colorSizesFromJson
  //       .map((colorSize) => ColorSize.fromJson(colorSize))
  //       .toList();
  //
  //   return Product(
  //     id: json['id'] ?? 0, // Default to 0 if null
  //     name: json['productName']?.toString() ?? 'Unknown Product', // Use toString() and default if null
  //     price: (json['productPrice'] != null && json['productPrice'] is num)
  //         ? (json['productPrice'] as num).toDouble()
  //         : 0.0, // Default to 0.0 if null or invalid type
  //     description: json['productDescription']?.toString() ?? 'No description available', // Default if null
  //     image: json['productImage']?.toString() ?? 'path_to_default_image', // Default if null
  //     categoryName: json['categoryName']?.toString() ?? 'Unknown Category', // Default if null
  //     colorSizes: colorSizesList, // Handle colorSizes gracefully, no fallback needed
  //   );
  // }






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
