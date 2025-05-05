import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/storage/local_storage_helper.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  var currentLocale = const Locale('en', 'US').obs;

  static Future<void> initialize() async {
    final controller = Get.put(AppController());
    await controller._loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    String langCode = await LocalStorageHelper.getLangCode();
    if (langCode == 'ar') {
      currentLocale.value = const Locale('ar', 'AR');
    } else {
      currentLocale.value = const Locale('en', 'US');
    }
    Get.updateLocale(currentLocale.value);
  }

  void changeLanguage(String langCode, String countryCode) {
    final locale = Locale(langCode, countryCode);
    currentLocale.value = locale;
    Get.updateLocale(locale);
    LocalStorageHelper.saveLangCode(langCode);
  }
}