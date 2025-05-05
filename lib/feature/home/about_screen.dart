import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';
import '../notes/notes_controller.dart';
import 'about_controller.dart';

class AboutAndPrivicy extends StatelessWidget {
  AboutAndPrivicy({super.key, this.isAbout});

  bool? isAbout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<AboutController>(
          init: AboutController(),
          builder: (controller) {
            return Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                isAbout == true
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(controller
                                    .termsPrivacyModel?.data?.termsPrivacy?.terms ??
                                ""),
                          ),
                        ],
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(controller
                                    .termsPrivacyModel?.data?.termsPrivacy?.privacy ??
                                ""),
                          ),
                        ],
                      ),
                    )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isAbout==true ? 'About'.tr : "Privacy Policy".tr,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 32), // حتى يبقى العنوان بالوسط
        ],
      ),
    );
  }

}
