import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';
import 'package:shop_app_clothes/pages/service/ProductService.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  final ProductService _productService = ProductService();

  // Observable variables
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final productList = await _productService.getAllProducts();
      products.assignAll(productList);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  // Lấy danh sách ảnh cho banner
  List<String> getBannerImages() {
    if (products.isNotEmpty) {
      return products.map((product) => product.image).toList();
    }
    return ['default_image_url']; // Thay bằng URL mặc định nếu cần
  }
}
