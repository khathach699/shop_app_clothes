import 'package:get/get.dart';

class AddressController extends GetxController {
  var name = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;

  void updateAddress(String newName, String newPhone, String newAddress) {
    name.value = newName;
    phone.value = newPhone;
    address.value = newAddress;
  }

  bool validate() {
    if (name.isEmpty || phone.isEmpty || address.isEmpty) {
      Get.snackbar("Error", "Please fill in all address fields");
      return false;
    }
    return true;
  }
}