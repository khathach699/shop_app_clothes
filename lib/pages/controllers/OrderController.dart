import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:shop_app_clothes/pages/models/OrderList.dart';
import 'package:shop_app_clothes/pages/models/User.dart';
import 'package:shop_app_clothes/pages/service/OrderService.dart';

import '../service/StorageService.dart';

class OrderController extends GetxController {
  var orders = <OrderList>[].obs;
  var isLoading = true.obs;
  int? userId;
  final OrderService orderService = OrderService();

  @override
  void onInit() async {
    super.onInit();
    await _loadUserId();
    await fetchOrders();
  }

  Future<void> _loadUserId() async {
    userId = await StorageService.getUserId();
    update();
  }
  // Fetch orders for the logged-in user
  Future<void> fetchOrders() async {
    isLoading.value = true;

    try {
      if (userId == null) {
        throw Exception("User ID is null");
      }

      final List<dynamic> fetchedData = await orderService.getOrdersByUserId(userId!);

      if (fetchedData.isEmpty) {
        print("No orders found");
        orders.clear(); // Xóa danh sách cũ nếu không có đơn hàng mới
        return;
      }

      print("Fetched orders: $fetchedData");

      final List<OrderList> fetchedOrders =
      fetchedData.map((orderData) => OrderList.fromJson(orderData)).toList();

      orders.assignAll(fetchedOrders);
    } catch (e, stackTrace) {
      print("Error fetching orders: $e");
      print("Stack trace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }

}
