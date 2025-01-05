import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/custom_shapes/container/primary_header_primary.dart';
import 'package:shop_app_clothes/common/widgets/list_titles/setting_menu_title.dart';
import 'package:shop_app_clothes/common/widgets/list_titles/user_profile_title.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/screens/order/order.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      "Setting",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: TColors.white),
                    ),
                  ),

                  TUserProfileUser(),
                  const SizedBox(height: TSize.spaceBtwSections),
                ],
              ),
            ),

            //
            Padding(
              padding: EdgeInsets.all(TSize.defaultSpace),
              child: Column(
                children: [
                  TSectionHeading(
                    title: "Account Settings",
                    showActionButton: false,
                  ),
                  SizedBox(height: TSize.spaceBtwItems),

                  TSettingMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: "Add",
                    subtitle: "Add new address",
                    onTap: () {},
                  ),
                  TSettingMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: "My Order",
                    subtitle: "Already have 12 orders",
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  TSettingMenuTitle(
                    icon: Iconsax.bank,
                    title: "bank account",
                    subtitle: "Paypal, Google Pay",
                    onTap: () {},
                  ),
                  TSettingMenuTitle(
                    icon: Iconsax.notification,
                    title: "Notification",
                    subtitle: "All notification on",
                    onTap: () {},
                  ),
                  TSettingMenuTitle(
                    icon: Iconsax.lock,
                    title: "Privacy",
                    subtitle: "System permission",
                    onTap: () {},
                  ),

                  // add setting
                  SizedBox(height: TSize.spaceBtwSections),
                  TSectionHeading(
                    title: "App Settings",
                    showActionButton: false,
                  ),

                  SizedBox(height: TSize.spaceBtwItems),

                  TSettingMenuTitle(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subtitle: "Your custom location",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  const SizedBox(height: TSize.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text("Log Out"),
                    ),
                  ),
                  const SizedBox(height: TSize.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
