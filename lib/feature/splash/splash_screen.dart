import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
 import '../../constant/app_colors.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.whitColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('assets/images/leb.png'),
              width: 140,
              height: 140,
            ),
            const SizedBox(height: 12),
            Text(
              'leb_elections'.tr,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            LoadingAnimationWidget.stretchedDots(
              color: AppColors.greenColor,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
