import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/success_screen/success_screen.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/pages/controllers/AddressController.dart';
import 'package:shop_app_clothes/pages/controllers/CartController.dart';
import 'package:shop_app_clothes/pages/controllers/ProductController.dart';
import 'package:shop_app_clothes/pages/models/OrderItem.dart';
import 'package:shop_app_clothes/pages/service/OrderService.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';

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
      List<OrderItem> orderItems = _prepareOrderItems(arguments);

      for (var item in orderItems) {
        print(
          "ProductId: ${item.productId}, ProductName: ${item.productName}, PriceAtOrder: ${item.priceAtOrder}",
        );
      }

      List<Map<String, dynamic>> filteredOrderItems =
          orderItems.map((item) {
            Map<String, dynamic> json = {
              "productId": item.productId,
              "quantity": item.quantity,
              "colorId": item.colorId,
              "sizeId": item.sizeId,
            };
            if (item.productName != null) {
              json["productName"] = item.productName;
            }
            if (item.priceAtOrder != null) {
              json["priceAtOrder"] = item.priceAtOrder;
            }

            return json;
          }).toList();

      final orderJson = {
        "userId": userId.value,
        "paymentMethodId": selectedPaymentMethodId.value,
        "userName": addressController.name.value,
        "address": addressController.address.value,
        "phoneNumber": addressController.phone.value,
        "orderItems": filteredOrderItems,
      };

      final success = await orderService.createOrder(orderJson);

      if (success) {
        Get.offAll(
          () => SuccessScreen(
            image: TImages.payment,
            title: 'Payment Successful!',
            subTitle: 'Your item has been successfully delivered.',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ),
        );
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
      orderItems =
          cartItems.map((cartItem) {
            return OrderItem(
              productId: cartItem.productId,
              quantity: cartItem.quantity,
              colorId: productController.colorMapping[cartItem.colorName] ?? 0,
              sizeId: productController.sizeMapping[cartItem.sizeName] ?? 0,
            );
          }).toList();
    } else if (arguments.containsKey('productId')) {
      print("Received productId: ${arguments}");
      orderItems.add(
        OrderItem(
          productId: arguments['productId'],
          quantity: arguments['quantity'] ?? 1,
          colorId: arguments['selectedColorId'] ?? 0,
          sizeId: arguments['selectedSizeId'] ?? 0,
          priceAtOrder: arguments['price'],
        ),
      );
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
