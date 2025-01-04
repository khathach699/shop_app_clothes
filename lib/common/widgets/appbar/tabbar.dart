import 'package:flutter/material.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';
import 'package:shop_app_clothes/utils/device/device_utility.dart';
import 'package:shop_app_clothes/utils/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: TColors.primaryColor,
      unselectedLabelColor: TColors.grey,
      labelColor:
          THelperFunctions.isDarkMode(context)
              ? TColors.white
              : TColors.primaryColor,
      tabs: tabs,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
