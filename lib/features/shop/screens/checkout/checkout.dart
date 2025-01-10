import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/success_screen/success_screen.dart';
import 'package:shop_app_clothes/features/shop/controllers/AddressController.dart';
import 'package:shop_app_clothes/features/shop/controllers/CartController.dart';
import 'package:shop_app_clothes/features/shop/controllers/ProductController.dart';
import 'package:shop_app_clothes/features/shop/models/Order.dart'; // Import Order model
import 'package:shop_app_clothes/features/shop/models/OrderItem.dart'; // Import OrderItem model
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/biling_payment_section.dart'
    as payment;
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:shop_app_clothes/features/shop/screens/service/OrderService.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../../../common/widgets/custom_shapes/container/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';

class TCheckOut extends StatelessWidget {
  const TCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());
    final OrderService orderService = OrderService();
    final box = GetStorage();
    int userId = box.read('userId') ?? 0;

    // Eagerly initialize CartController
    final CartController controller = Get.put(CartController());
    final ProductController productController = Get.put(ProductController());

    // Lấy cartItems được truyền từ CartScreen
    final Map<String, dynamic> arguments = Get.arguments ?? {};

    // Kiểm tra nếu có giỏ hàng (List)
    List<dynamic> cartItems = [];
    if (arguments['cartItems'] is List) {
      cartItems = arguments['cartItems'];
    }

    // Kiểm tra nếu có đơn hàng (Map)
    Map<String, dynamic> order = {};
    if (arguments['order'] is Map) {
      order = arguments['order'];
    }

    // Bây giờ bạn có thể xử lý `cartItems` hoặc `order` tùy thuộc vào dữ liệu nhận được.

    print("${cartItems}");

    // Mã phương thức thanh toán mặc định
    int selectedPaymentMethodId = 1;

    // Cập nhật mã phương thức thanh toán
    void updatePaymentMethodId(int selectedId) {
      selectedPaymentMethodId = selectedId;
    }

    Future<void> _handleCheckout() async {
      List<OrderItem> orderItems = [];

      if (cartItems.isNotEmpty) {
        // Nếu cartItems là List
        orderItems =
            cartItems.map((cartItem) {
              return OrderItem(
                productId: cartItem.productId,
                quantity: cartItem.quantity,
              );
            }).toList();
      } else if (arguments.containsKey('productId')) {
        // Kiểm tra nếu là Map (chỉ kiểm tra productId)
        orderItems.add(
          OrderItem(
            productId: arguments['productId'],
            quantity: arguments['quantity'],
          ),
        );
      }

      // Tạo đối tượng Order
      Order order = Order.fromCartItems(
        userId,
        selectedPaymentMethodId,
        addressController.name.value,
        addressController.address.value,
        addressController.phone.value,
        orderItems,
      );

      // Gửi yêu cầu tạo đơn hàng
      bool success = await orderService.createOrder(order.toJson());

      if (success) {
        // Hiển thị màn hình thành công
        Get.to(
          () => SuccessScreen(
            image: TImages.payment,
            title: 'Payment Successful!',
            subTitle: 'Your item has been successfully delivered.',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ),
        );
      } else {
        // Hiển thị thông báo lỗi
        Get.snackbar(
          "Error",
          "Failed to create the order. Please try again!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Order View",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              TCouponCode(),
              const SizedBox(height: TSize.spaceBtwSections),
              TRoundContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSize.md),
                child: Column(
                  children: [
                    TBillingAmountSection(),
                    const SizedBox(height: TSize.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: TSize.spaceBtwItems),
                    payment.TBillingPaymentSection(
                      onPaymentMethodSelected: updatePaymentMethodId,
                    ),
                    const SizedBox(height: TSize.spaceBtwItems),
                    const Divider(),
                    TBillingAddressSection(),
                    const SizedBox(height: TSize.spaceBtwItems),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSize.defaultSpace),
        child: ElevatedButton(
          onPressed: _handleCheckout,
          child: Obx(() {
            // Check if CartController's totalPrice is null or 0
            double total;
            if (cartItems.isNotEmpty) {
              total =
                  controller.totalPrice > 0
                      ? productController.totalPrice
                      : controller.totalPrice;
            } else {
              total = productController.totalPrice;
            }

            return Text(
              "\$${total.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium,
            );
          }),
        ),
      ),
    );
  }
}
