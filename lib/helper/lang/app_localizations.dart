import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => AppTranslations.translations;

  static const Locale fallbackLocale = Locale('en', 'US');

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'AR'),
  ];

  static void changeLocale(String langCode, String countryCode) {
    final locale = Locale(langCode, countryCode);
    Get.updateLocale(locale);
  }
}