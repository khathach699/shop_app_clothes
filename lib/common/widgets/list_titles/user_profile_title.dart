import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/images/t_circular_Image.dart';
import 'package:shop_app_clothes/pages/address/profile/proflie.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';

import '../../../pages/controllers/UserController.dart';

class TUserProfileUser extends StatelessWidget {
  const TUserProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return ListTile(
      leading: const TCircularImage(
        image: TImages.shoe3,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Obx(() => Text(
        userController.user.value?.username ?? "Loading.....",
        style: Theme.of(
          context,
        ).textTheme.headlineMedium!.apply(color: TColors.white),
      ),
      ),

      subtitle: Obx(() => Text(
        userController.user.value?.email ?? "Loading....." ,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.apply(color: TColors.white),
      ),),

      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: Icon(Iconsax.edit, color: TColors.white, size: 20),
      ),
    );
  }
}
