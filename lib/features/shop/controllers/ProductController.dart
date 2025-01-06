import 'package:get/get.dart';

class ProductController extends GetxController {
  // Observable variable to store the selected size
  var selectedSize = ''.obs;

  // Observable variable to store the selected color
  var selectedColor = ''.obs;

  // Function to set the selected size
  void setSelectedSize(String size) {
    // Ensure size is updated
    if (selectedSize.value != size) {
      selectedSize.value = size;
    }
  }

  // Function to set the selected color
  void setSelectedColor(String color) {
    // Ensure color is updated
    if (selectedColor.value != color) {
      selectedColor.value = color;
    }
  }
}
