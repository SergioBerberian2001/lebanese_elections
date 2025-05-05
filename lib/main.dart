import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'feature/app_controller.dart';
import 'feature/splash/splash_screen.dart';
import 'helper/lang/app_localizations.dart';
import 'feature/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppController.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find<AppController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lebanon Elections',
      locale: appController.currentLocale.value,
      fallbackLocale: AppLocalization.fallbackLocale,
      translations: AppLocalization(),
      supportedLocales: AppLocalization.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
