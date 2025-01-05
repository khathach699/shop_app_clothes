import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:shop_app_clothes/common/widgets/products/cart/coupon_widget.dart';
import 'package:shop_app_clothes/common/widgets/success_screen/success_screen.dart';
import 'package:shop_app_clothes/features/shop/screens/cart/widgets/cart_item.dart';
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/biling_payment_section.dart'
    as payment;
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:shop_app_clothes/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:shop_app_clothes/navigation_menu.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TCheckOut extends StatelessWidget {
  const TCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
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
              TCartItems(showAddRemoveButtons: false),
              SizedBox(height: TSize.spaceBtwSections),

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
          onPressed:
              () => Get.to(
                () => SuccessScreen(
                  image: TImages.shoe1,
                  title: 'Payment Successful!',
                  subTitle: 'Your item has been successfully delivered.',
                  onPressed: () => Get.offAll(() => const NavigationMenu()),
                ),
              ),
          child: Text("CheckOut \$265"),
        ),
      ),
    );
  }
}
