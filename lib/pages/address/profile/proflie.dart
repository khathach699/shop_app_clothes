import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/common/widgets/images/t_circular_Image.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/pages/address/profile/widgets/profile_menu.dart';
import 'package:shop_app_clothes/utils/constants/image_strings.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              TProfileMenu(
                title: 'Name',
                value: 'Stone king',
                icon: Iconsax.arrow_right_34,
                onTap: () {},
              ),
              TProfileMenu(
                title: 'Username',
                value: 'Stone king',
                icon: Iconsax.arrow_right_34,
                onTap: () {},
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSize.spaceBtwItems),

              TSectionHeading(
                title: "Profile Details",
                showActionButton: false,
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              TProfileMenu(
                title: 'UserID',
                value: '4578',
                icon: Iconsax.copy,
                onTap: () {},
              ),
              TProfileMenu(
                title: 'E-Mail',
                value: 'Stoneking@gmail.com',
                icon: Iconsax.arrow_right_34,
                onTap: () {},
              ),
              TProfileMenu(
                title: 'Phone Number',
                value: '+1 987 654 3210',
                icon: Iconsax.arrow_right_34,
                onTap: () {},
              ),
              TProfileMenu(
                title: 'Gender',
                value: 'Male',
                icon: Iconsax.arrow_right_34,
                onTap: () {},
              ),
              TProfileMenu(
                title: 'Date of Birth',
                value: '12-12-2003',
                icon: Iconsax.arrow_right_34,
                onTap: () {},
              ),
              const Divider(),
              const SizedBox(height: TSize.spaceBtwItems),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text("Close Account"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
