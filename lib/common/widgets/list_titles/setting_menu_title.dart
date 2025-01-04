import 'package:flutter/material.dart';
import 'package:shop_app_clothes/utils/constants/colors.dart';

class TSettingMenuTitle extends StatelessWidget {
  const TSettingMenuTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.primaryColor),
      title: Text(
        title,
        // style: Theme.of(
        //   context,
        // ).textTheme.headlineMedium!.apply(color: TColors.white),
      ),
      subtitle: Text(
        subtitle,
        // style: Theme.of(
        //   context,
        // ).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
