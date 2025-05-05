import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../network/app_exception.dart';
import '../notes/notes_provider.dart';
import 'modle/about_and_privicy.dart';

class AboutController extends GetxController {
  bool isLoading = true;
  TermsPrivacyModel? termsPrivacyModel;
  bool isSubmitting = false;

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  void getNotes() {
    isLoading = true;
    update();
    NotesProvider().getTermsAndPrivacy({}).then((v) {
      isLoading = false;
      if (v is! AppException) {
        termsPrivacyModel = v;
      } else {
        Get.snackbar(
          v.message ?? "Error",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      update();
    });
  }

  void addNote(String text) {
    isSubmitting = true;
    update();

    Map<String, String> body = {
      "text": text,
    };

    NotesProvider().addNote(body).then((v) {
      isSubmitting = false;
      if (v is! AppException) {
        Get.back(); // نسكر الـ Dialog
        getNotes(); // نرجع نجيب النوتس
      } else {
        Get.snackbar(
          v.message ?? "Error",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      update();
    });
  }
}
