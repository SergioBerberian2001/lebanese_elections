import 'package:get/get.dart';
import '../../helper/storage/local_storage_helper.dart';
import '../login/login_screen.dart';
import '../main/main_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 1));

    final isLoggedIn = await LocalStorageHelper.isLoggedIn();

    if (isLoggedIn) {
      Get.offAll(() => MainScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }
}
