import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/features/shop/controllers/AddressController.dart';
import '../../../../utils/constants/size.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text("Add Address")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Name",
                  ),
                  onChanged: (value) {
                    addressController.name.value = value;
                  },
                ),
                const SizedBox(height: TSize.spaceBtwInputField),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: "Phone Number",
                  ),
                  onChanged: (value) {
                    addressController.phone.value = value;
                  },
                ),
                const SizedBox(height: TSize.spaceBtwInputField),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: "Address",
                  ),
                  onChanged: (value) {
                    addressController.address.value = value;
                  },
                ),
                const SizedBox(height: TSize.spaceBtwInputField),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // When pressed, navigate back to the previous screen and pass the data
                      Get.back(result: addressController);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
