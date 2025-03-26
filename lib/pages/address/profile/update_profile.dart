import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:shop_app_clothes/utils/constants/size.dart';

import '../../controllers/UserController.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  final UserController userController = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = userController.user.value?.username ?? "";
    passwordController.text = "";
    phoneController.text = "";
    genderController.text = "";
    dobController.text = "";
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile")),
      body: Padding(
        padding: EdgeInsets.all(TSize.defaultSpace),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username", prefixIcon: Icon(Iconsax.user)),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Iconsax.password_check)),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone", prefixIcon: Icon(Iconsax.call)),
            ),
            SizedBox(height: 20),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: "Gender", prefixIcon: Icon(Iconsax.profile)),
            ),
            SizedBox(height: 20),
            TextField(
              controller: dobController,
              decoration: InputDecoration(labelText: "Date of Birth", prefixIcon: Icon(Iconsax.calendar)),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Center(
              child: Obx(() => SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: ()  {
                {
                  Map<String, dynamic> updatedData = {
                  "username": usernameController.text,
                  "password": passwordController.text,
                  "phone": phoneController.text,
                  "gender": genderController.text,
                  "dateOfBirth": dobController.text,
                };
                    userController.updateUserInfo(updatedData);
              }
                  },
                  child:userController.isLoading.value ? CircularProgressIndicator() :  Text("Update User"),
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
