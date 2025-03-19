import 'package:get/get.dart';

class ProductController extends GetxController {
  // Observable variables to store selected size, color, and quantity
  var selectedSize = ''.obs;
  var selectedColor = ''.obs;
  var quantity = 1.obs;

  // Price for the selected product
  double productPrice =
      50.0; // Example price. You should fetch this dynamically.

  // Color and Size Mappings (You should adjust these values based on your actual data)
  final Map<String, int> colorMapping = {
    'white': 1,
    'Black': 2,
    'Green': 3,
    'Blue': 4,
    'LightGreen': 5,
    // Add other color mappings here
  };

  final Map<String, int> sizeMapping = {
    'S': 1,
    'M': 2,
    'L': 3,
    'XL': 4,
    'XXL': 5,
    // Add other size mappings here
  };

  // Function to set the selected size
  void setSelectedSize(String size) {
    if (selectedSize.value != size) {
      selectedSize.value = size;
    }
  }

  // Function to set the selected color
  void setSelectedColor(String color) {
    if (selectedColor.value != color) {
      selectedColor.value = color;
    }
  }

  int getSelectedColorId() {
    return colorMapping[selectedColor.value] ?? 0; // Default to 0 if not found
  }

  // Function to get the selected size's ID
  int getSelectedSizeId() {
    return sizeMapping[selectedSize.value] ?? 0; // Default to 0 if not found
  }

  // Function to increment quantity
  void incrementQuantity() {
    quantity.value++;
  }

  // Function to decrement quantity
  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // Function to calculate total price
  double get totalPrice {
    return productPrice * quantity.value;
  }
}
