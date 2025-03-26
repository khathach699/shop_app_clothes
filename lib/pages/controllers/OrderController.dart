import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:shop_app_clothes/pages/models/OrderList.dart';
import 'package:shop_app_clothes/pages/models/User.dart';
import 'package:shop_app_clothes/pages/service/OrderService.dart';

import '../service/StorageService.dart';

class OrderController extends GetxController {
  var orders = <OrderList>[].obs;
  var isLoading = true.obs;
  final userId = Rxn<int>();
  final OrderService orderService = OrderService();

  @override
  void onInit() async {
    super.onInit();
    await _loadUserId();
    await fetchOrders();
  }

  Future<void> _loadUserId() async {
    userId.value = await StorageService.getUserId();
  }
  // Fetch orders for the logged-in user
  Future<void> fetchOrders() async {
    isLoading.value = true;

    try {
      final List<dynamic> fetchedData = await orderService.getOrdersByUserId(
        userId as int,
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
