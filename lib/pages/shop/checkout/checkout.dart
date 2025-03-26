import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/common/widgets/products/cart/coupon_widget.dart';
import '../../controllers/AddressController.dart';
import '../../controllers/CartController.dart';
import '../../controllers/ProductController.dart';
import '../../controllers/CheckoutController.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';
import 'widgets/biling_payment_section.dart' as payment;

class TCheckOut extends StatelessWidget {
  const TCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo các Controller cần thiết
    Get.put(AddressController());
    Get.put(CartController());
    Get.put(ProductController());
    final CheckoutController checkoutController = Get.put(CheckoutController());

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
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              const TCouponCode(),
              const SizedBox(height: TSize.spaceBtwSections),
              TRoundContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSize.md),
                child: Column(
                  children: [
                    const TBillingAmountSection(),
                    const SizedBox(height: TSize.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: TSize.spaceBtwItems),
                    payment.TBillingPaymentSection(
                      onPaymentMethodSelected:
                      checkoutController.updatePaymentMethodId,
                    ),
                    const SizedBox(height: TSize.spaceBtwItems),
                    const Divider(),
                    const TBillingAddressSection(),
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
        child: Obx(
              () => ElevatedButton(
            onPressed: checkoutController.isLoading.value
                ? null
                : checkoutController.handleCheckout,
            child: Text(
              checkoutController.isLoading.value ? "Processing..." : "Payment",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}