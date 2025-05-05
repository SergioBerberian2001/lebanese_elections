import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../network/app_exception.dart';
import 'notes_model.dart';
import 'notes_provider.dart';

class NotesController extends GetxController {
  bool isLoading = true;
  NotesModelResponse? notesModelResponse;
  bool isSubmitting = false;

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  void getNotes() {
    isLoading = true;
    update();
    NotesProvider().getNotes({}).then((v) {
      isLoading = false;
      if (v is! AppException) {
        notesModelResponse = v;
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
