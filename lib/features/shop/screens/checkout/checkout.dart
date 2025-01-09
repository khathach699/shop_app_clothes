import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/success_screen/success_screen.dart';
import 'package:shop_app_clothes/features/shop/controllers/AddressController.dart';
import 'package:shop_app_clothes/features/shop/controllers/CartController.dart';
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/biling_payment_section.dart'
    as payment;
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:shop_app_clothes/features/shop/screens/service/OrderService.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../../../common/widgets/custom_shapes/container/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import 'package:shop_app_clothes/features/shop/models/Order.dart'; // Import Order model
import 'package:shop_app_clothes/features/shop/models/OrderItem.dart'; // Import OrderItem model

class TCheckOut extends StatelessWidget {
  const TCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());
    final OrderService orderService = OrderService();
    final box = GetStorage();
    int userId = box.read('userId') ?? 0;
    final CartController controller = Get.find<CartController>();

    // Lấy cartItems được truyền từ CartScreen
    final Map<String, dynamic> arguments = Get.arguments ?? {};
    List<dynamic> cartItems = arguments['cartItems'] ?? [];
    print("${cartItems}");

    // Mã phương thức thanh toán mặc định
    int selectedPaymentMethodId = 1;

    // Cập nhật mã phương thức thanh toán
    void updatePaymentMethodId(int selectedId) {
      selectedPaymentMethodId = selectedId;
    }

    Future<void> _handleCheckout() async {
      // Chuyển đổi CartItems thành OrderItems
      List<OrderItem> orderItems =
          cartItems.map((cartItem) {
            return OrderItem(
              productId: cartItem.productId,
              quantity: cartItem.quantity,
            );
          }).toList();

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
          child: Obx(
            () => Text(
              "\$${controller.totalPrice.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
