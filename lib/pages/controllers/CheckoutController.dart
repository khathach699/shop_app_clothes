import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/success_screen/success_screen.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/pages/controllers/AddressController.dart';
import 'package:shop_app_clothes/pages/controllers/CartController.dart';
import 'package:shop_app_clothes/pages/controllers/ProductController.dart';
import 'package:shop_app_clothes/pages/models/Order.dart';
import 'package:shop_app_clothes/pages/models/OrderItem.dart';
import 'package:shop_app_clothes/pages/service/OrderService.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:get_storage/get_storage.dart';

import '../service/StorageService.dart';

class CheckoutController extends GetxController {
  final AddressController addressController = Get.find();
  final CartController cartController = Get.find();
  final ProductController productController = Get.find();
  final OrderService orderService = OrderService();
  var selectedPaymentMethodId = 1.obs; // Observable
  var isLoading = false.obs;
  final userId = Rxn<int>();

  @override
  void onInit() async {
    super.onInit();
    await _loadUserId();
  }

  void updatePaymentMethodId(int selectedId) {
    selectedPaymentMethodId.value = selectedId;
  }
  Future<void> _loadUserId() async {
    userId.value = await StorageService.getUserId();
  }

  Future<void> handleCheckout() async {
    isLoading.value = true;

    try {
      final arguments = Get.arguments ?? {};
      print("Arguments: $arguments"); // Debug

      // Chuẩn bị danh sách OrderItem từ cartItems
      List<OrderItem> orderItems = _prepareOrderItems(arguments);

      // In ra danh sách trước khi lọc
      print("Order Items Before Fix:");
      for (var item in orderItems) {
        print("ProductId: ${item.productId}, ProductName: ${item.productName}, PriceAtOrder: ${item.priceAtOrder}");
      }

      // Loại bỏ các trường `productName` và `priceAtOrder` nếu null
      List<Map<String, dynamic>> filteredOrderItems = orderItems.map((item) {
        Map<String, dynamic> json = {
          "productId": item.productId,
          "quantity": item.quantity,
          "colorId": item.colorId,
          "sizeId": item.sizeId,
        };

        // Chỉ thêm productName nếu nó không null
        if (item.productName != null) {
          json["productName"] = item.productName;
        }

        // Chỉ thêm priceAtOrder nếu nó không null
        if (item.priceAtOrder != null) {
          json["priceAtOrder"] = item.priceAtOrder;
        }

        return json;
      }).toList();

      // In ra danh sách sau khi lọc
      print("Filtered Order Items:");
      print(filteredOrderItems);

      // Tạo đối tượng Order JSON
      final orderJson = {
        "userId": userId.value,
        "paymentMethodId": selectedPaymentMethodId.value,
        "userName": addressController.name.value,
        "address": addressController.address.value,
        "phoneNumber": addressController.phone.value,
        "orderItems": filteredOrderItems
      };

      print("Final Order JSON: $orderJson");

      // Gửi yêu cầu tạo đơn hàng
      final success = await orderService.createOrder(orderJson);

      if (success) {
        Get.offAll(() => SuccessScreen(
          image: TImages.payment,
          title: 'Payment Successful!',
          subTitle: 'Your item has been successfully delivered.',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ));
      } else {
        _showErrorSnackBar("Failed to create the order. Please try again!");
      }
    } catch (e) {
      _showErrorSnackBar("An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }


  List<OrderItem> _prepareOrderItems(Map<String, dynamic> arguments) {
    List<OrderItem> orderItems = [];
    final cartItems = arguments['cartItems'] as List<dynamic>? ?? [];

    if (cartItems.isNotEmpty) {
      orderItems = cartItems.map((cartItem) {
        return OrderItem(
          productId: cartItem.productId,
          quantity: cartItem.quantity,
          colorId: productController.colorMapping[cartItem.colorName] ?? 0,
          sizeId: productController.sizeMapping[cartItem.sizeName] ?? 0,
        );
      }).toList();
    } else if (arguments.containsKey('productId')) {
      orderItems.add(OrderItem(
        productId: arguments['productId'],
        quantity: arguments['quantity'],
        colorId: arguments["selectedColorId"],
        sizeId: arguments["selectedSizeId"],
      ));
    }

    return orderItems;
  }

  void _showErrorSnackBar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}