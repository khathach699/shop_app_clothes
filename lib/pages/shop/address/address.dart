import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app_clothes/common/widgets/appbar/appbar.dart';
import 'package:shop_app_clothes/pages/controllers/AddressController.dart';

import '../../../utils/constants/size.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  Future<String> _getCurrentLocation() async {
    // Kiểm tra nếu dịch vụ định vị đang được bật
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "Dịch vụ định vị bị vô hiệu hóa.";
    }

    // Kiểm tra quyền truy cập vị trí
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Quyền truy cập vị trí bị từ chối.";
      }
    }

    // Lấy vị trí hiện tại
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Trả về tọa độ (Có thể thay thế bằng một dịch vụ geocoding để lấy địa chỉ hoàn chỉnh)
    return "Lat: ${position.latitude}, Long: ${position.longitude}"; // Bạn có thể thay thế phần này bằng geocoding để lấy địa chỉ đầy đủ
  }

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text("Thêm Địa Chỉ")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Form(
            child: Column(
              children: [
                // Trường nhập tên
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Tên",
                  ),
                  onChanged: (value) {
                    addressController.name.value = value;
                  },
                ),
                const SizedBox(height: TSize.spaceBtwInputField),

                // Trường nhập số điện thoại
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: "Số Điện Thoại",
                  ),
                  onChanged: (value) {
                    addressController.phone.value = value;
                  },
                ),
                const SizedBox(height: TSize.spaceBtwInputField),

                // Trường nhập địa chỉ
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: "Địa Chỉ",
                  ),
                  onChanged: (value) {
                    addressController.address.value = value;
                  },
                ),
                const SizedBox(height: TSize.spaceBtwInputField),

                //  Obx(
                //   () => TextFormField(
                //     controller: TextEditingController(
                //       text: addressController.address.value,
                //     ),
                //     decoration: const InputDecoration(
                //       prefixIcon: Icon(Iconsax.building_31),
                //       labelText: "Địa Chỉ",
                //     ),
                //     onChanged: (value) {
                //       addressController.address.value = value;
                //     },
                //   ),
                // ),
                // const SizedBox(height: TSize.spaceBtwInputField),

                // Nút lấy địa chỉ hiện tại
                ElevatedButton(
                  onPressed: () async {
                    String location = await _getCurrentLocation();
                    addressController.address.value = location;
                  },

                  child: Text("Sử Dụng Vị Trí Hiện Tại"),
                ),

                const SizedBox(height: TSize.spaceBtwInputField),

                // Nút lưu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Khi nhấn, quay lại màn hình trước và truyền dữ liệu
                      Get.back(result: addressController);
                    },
                    child: Text("Lưu"),
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
