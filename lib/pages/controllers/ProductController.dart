import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductController extends GetxController {
  var selectedSize = ''.obs;
  var selectedColor = ''.obs;
  var quantity = 1.obs;
  var productPrice = 50.0.obs;

  final Map<String, int> colorMapping = {
    'White': 1,
    'Black': 2,
    'Green': 3,
    'Blue': 4,
    'LightGreen': 5,
  };

  final Map<String, int> sizeMapping = {
    'S': 1,
    'M': 2,
    'L': 3,
    'XL': 4,
    'XXL': 5,
  };


  void setSelectedSize(String size) => selectedSize.value = size;
  void setSelectedColor(String color) => selectedColor.value = color;
  void incrementQuantity() => quantity.value++;
  void decrementQuantity() => quantity.value > 1 ? quantity.value-- : null;

  int getSelectedColorId() => colorMapping[selectedColor.value] ?? 0;
  int getSelectedSizeId() => sizeMapping[selectedSize.value] ?? 0;
  double get totalPrice => productPrice.value * quantity.value;

  void fetchProductPrice(int productId) async {
    await Future.delayed(const Duration(seconds: 1));
    productPrice.value = 75.0; // Giá mới từ API
  }

  void checkout(int productId) {
    Get.toNamed(
      '/checkout',
      arguments: {
        'productId': productId,
        'quantity': quantity.value,
        'selectedColorId': getSelectedColorId(),
        'selectedSizeId': getSelectedSizeId(),
        'price': productPrice.value,
      },
    );
  }
}
