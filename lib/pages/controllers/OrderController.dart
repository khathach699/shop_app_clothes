import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:shop_app_clothes/pages/models/OrderList.dart';
import 'package:shop_app_clothes/pages/service/OrderService.dart';

class OrderController extends GetxController {
  var orders = <OrderList>[].obs; // Observable list of Order models
  var isLoading = true.obs; // Observable loading state

  final OrderService orderService = OrderService();

  // Fetch orders for the logged-in user
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
    } finally {
      isLoading.value = false;
    }
  }
}
