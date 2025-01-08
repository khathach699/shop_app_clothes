import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/success_screen/success_screen.dart';
import 'package:shop_app_clothes/features/shop/controllers/AddressController.dart';
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

class TCheckOut extends StatelessWidget {
  const TCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());
    final OrderService orderService = OrderService();

    Future<void> _handleCheckout() async {
      // Chuẩn bị dữ liệu đơn hàng
      final Map<String, dynamic> orderData = {
        "userId": 1, // Thay bằng ID người dùng
        "paymentMethodId": 1, // Mapping với phương thức thanh toán
        "userName": addressController.name.value,
        "address": addressController.address.value,
        "phoneNumber": addressController.phone.value,
        "orderItems": [
          {
            "productId": 1,
            "quantity": 2,
          }, // Thay bằng sản phẩm thực tế trong giỏ hàng
          {"productId": 2, "quantity": 1},
        ],
      };

      // Gửi yêu cầu tạo đơn hàng
      bool success = await orderService.createOrder(orderData);

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

                    payment.TBillingPaymentSection(),
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
          onPressed: _handleCheckout, // Gọi hàm xử lý khi nhấn "CheckOut"
          child: Text("CheckOut \$265"),
        ),
      ),
    );
  }
}
