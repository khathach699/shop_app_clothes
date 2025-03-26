import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/images/t_circular_Image.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/pages/address/profile/widgets/profile_menu.dart';
import 'package:shop_app_clothes/pages/address/profile/update_profile.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../controllers/UserController.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text("Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(image: TImages.shoe3, width: 80, height: 80),
                    TextButton(
                      onPressed: () {},
                      child: Text("Change Profile Picture"),
                    ),
                  ],
                ),
              ),

              // Details
              const SizedBox(height: TSize.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSize.spaceBtwItems),
              TSectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              Obx(() => TProfileMenu(
                title: 'Username',
                value: userController.user.value?.username ?? "userName",
                icon: Iconsax.arrow_right_34,
                onTap: () {
                  Get.to(() => UpdateProfileScreen());
                },
                ),
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSize.spaceBtwItems),

              TSectionHeading(
                title: "Profile Details",
                showActionButton: false,
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              Obx(() => Column(
                children: [
                  TProfileMenu(
                    title: 'UserID',
                    value: userController.userId.value?.toString() ?? "userId",
                    icon: Iconsax.copy,
                    onTap: () {},
                  ),
                  TProfileMenu(
                    title: 'E-Mail',
                    value: userController.user.value?.email ?? "email",
                    icon: Iconsax.arrow_right_34,
                    onTap: () {},
                  ),
                  TProfileMenu(
                    title: 'Phone Number',
                    value: userController.user.value?.phone ?? "000",
                    icon: Iconsax.arrow_right_34,
                    onTap: () {},
                  ),
                  TProfileMenu(
                    title: 'Gender',
                    value: userController.user.value?.gender ?? "male",
                    icon: Iconsax.arrow_right_34,
                    onTap: () {},
                  ),
                  TProfileMenu(
                    title: 'Date of Birth',
                    value: userController.user.value?.dateOfBirth != null ? DateFormat("yyyy-MM-dd").format(userController.user.value!.dateOfBirth!) : "0",
                    icon: Iconsax.arrow_right_34,
                    onTap: () {},
                  ),
                ],
              )),
              const Divider(),
              const SizedBox(height: TSize.spaceBtwItems),

              Center(
                child: Obx(() => SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => userController.logout(),
                    child:userController.isLoading.value ? CircularProgressIndicator() :  Text("Close Account"),
                  ),
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
