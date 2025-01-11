import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:shop_app_clothes/features/shop/models/OrderList.dart';
import 'package:shop_app_clothes/features/shop/service/OrderService.dart';

class OrderController extends GetxController {
  var orders = <OrderList>[].obs; // Observable list of Order models
  var isLoading = true.obs; // Observable loading state

  final OrderService orderService = OrderService();

  // Fetch orders for the logged-in user
  Future<void> fetchOrders() async {
    print("fetchOrders started"); // Kiểm tra khi hàm bắt đầu
    isLoading.value = true;

    final box = GetStorage();
    int userId = box.read('userId') ?? 0;

    if (userId == 0) {
      print("Error: userId not found in GetStorage.");
      isLoading.value = false;
      return;
    }

    try {
      final List<dynamic> fetchedData = await orderService.getOrdersByUserId(
        userId,
      );
      print("Fetched Data: $fetchedData"); // In dữ liệu từ API
      final List<OrderList> fetchedOrders =
          fetchedData
              .map((orderData) => OrderList.fromJson(orderData))
              .toList();
      orders.assignAll(fetchedOrders);
      print("Orders updated: ${orders.length}"); // Kiểm tra số lượng đơn hàng
    } catch (e) {
      print("Error in fetchOrders: $e");
    } finally {
      isLoading.value = false; // Đảm bảo isLoading luôn được đặt thành false
      print("fetchOrders ended"); // Kiểm tra khi hàm kết thúc
    }
  }
}
