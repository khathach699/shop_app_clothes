import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop_app_clothes/common/widgets/texts/section_heading.dart';
import 'package:shop_app_clothes/features/shop/controllers/AddressController.dart';
import 'package:shop_app_clothes/features/shop/screens/address/address.dart';
import 'package:shop_app_clothes/utils/constants/size.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: "Shipping Address",
          buttonTitle: "Change",
          onPressed: () async {
            // Wait for the data passed back from the address screen
            var result = await Get.to(() => UserAddressScreen());

            if (result != null) {
              addressController.name.value = result.name.value;
              addressController.phone.value = result.phone.value;
              addressController.address.value = result.address.value;
            }
          },
        ),
        Obx(
          () => Row(
            children: [
              const Icon(Iconsax.user, color: Colors.grey, size: 16),
              const SizedBox(width: TSize.spaceBtwItems),
              Text(
                addressController.name.value.isEmpty
                    ? "Stone king"
                    : addressController.name.value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSize.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              const Icon(Icons.phone, color: Colors.grey, size: 16),
              const SizedBox(width: TSize.spaceBtwItems),
              Text(
                addressController.phone.value.isEmpty
                    ? "0392174740"
                    : addressController.phone.value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSize.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              const Icon(Icons.location_history, color: Colors.grey, size: 16),
              const SizedBox(width: TSize.spaceBtwItems),
              Text(
                addressController.address.value.isEmpty
                    ? "VietNamese GiaLai"
                    : addressController.address.value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
