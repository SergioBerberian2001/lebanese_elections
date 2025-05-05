import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../feature/login/model/login_response.dart';
import '../../feature/login/login_repository.dart';
import '../../helper/storage/local_storage_helper.dart';
import '../main/main_screen.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final LoginRepository _loginRepository = LoginRepository();
  User? currentUser;
  bool isClickButton = false;
  bool isLoading = false;

  void loadUserData() async {
    currentUser = await LocalStorageHelper.getUserData();
    update();
  }

  Future<void> sendLogin() async {
    final username = usernameController.text.trim();

    if (username.isEmpty) {
      Get.snackbar(
        'Code is required'.tr,
        ''.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
      return;
    }

    isClickButton = true;
    isLoading = true;
    update();

    try {
      final response = await _loginRepository.postLogin({'code': username});

      if (response.data?.token != null && response.data?.user != null) {
        await LocalStorageHelper.saveLoginData(
          username: username,
          password: '', // Add password if used
          token: response.data!.token!,
          userData: response.data!.user!,
        );

        Get.offAll(() =>   MainScreen());
      } else {
        Get.snackbar(
          'Login Failed'.tr,
          'Invalid code'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
