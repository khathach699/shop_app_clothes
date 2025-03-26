import 'package:get/get.dart';
import 'package:shop_app_clothes/pages/models/User.dart';
import '../service/StorageService.dart';
import '../service/UserService.dart';

class UserController extends GetxController{
  final isLoading = false.obs;
  final userId = Rxn<int>();
  final user = Rxn<User>();
  @override
  void onInit() async {
    super.onInit();
    await _loadUserId();
    await getInfoUser(userId.value!);
  }

  Future<void> _loadUserId() async {
    userId.value = await StorageService.getUserId();
  }

  Future<void> getInfoUser(int userId) async{
    try{
      isLoading.value = true;
      final fetchedUser = await UserService().getUserById(userId);
      user.value = fetchedUser;
    }catch(e){
      print("Lỗi: $e");
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> updateUserInfo(Map<String, dynamic> updatedData) async {
    try {
      isLoading.value = true;
      if (userId.value == null) return;

      final updatedUser = await UserService().updateUser(
          userId.value!, updatedData);
      user.value = updatedUser;
      Get.back();
    } catch (e) {
      print("Lỗi cập nhật user: $e");
    } finally {
      isLoading.value = false;
    }
  }

      Future<void> logout() async {
    isLoading.value = true;
    await StorageService.clearUserId();
    userId.value = null;
    Future.delayed(Duration(seconds: 1), (){
      isLoading.value = false;
      Get.offAllNamed('/signIn');
    });
  }
}