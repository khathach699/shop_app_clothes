import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:shop_app_clothes/pages/models/OrderList.dart';
import 'package:shop_app_clothes/pages/service/OrderService.dart';

class OrderController extends GetxController {
  var orders = <OrderList>[].obs;
  var isLoading = true.obs;

  final OrderService orderService = OrderService();

  Future<void> fetchOrders() async {
    isLoading.value = true;

    final box = GetStorage();
    int userId = box.read('userId') ?? 0;

    if (userId == 0) {
      isLoading.value = false;
      return;
    }

    try {
      final List<dynamic> fetchedData = await orderService.getOrdersByUserId(
        userId,
      );

      final List<OrderList> fetchedOrders =
          fetchedData
              .map((orderData) => OrderList.fromJson(orderData))
              .toList();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      print("Error in fetchOrders: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
