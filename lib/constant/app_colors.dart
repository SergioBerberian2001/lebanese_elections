import 'package:flutter/material.dart';

class AppColors {
  // static void initialThemColor() async {
  //
  //   Schools? selectedSchool= await LocalStorageHelper.getSelectedSchool();
  //   try {
  //
  //     if (selectedSchool?.themeMainColor?.isNotEmpty ?? false) {
  //       themeMainColor = Color(int.parse("0xFF${selectedSchool?.themeMainColor?.replaceAll("#", "")}",
  //       ));
  //     } else {
  //       themeMainColor = null;
  //     }
  //   } catch (e) {
  //     themeMainColor = null;
  //     log(e.toString());
  //   }
  //   try {
  //     if (selectedSchool?.themeSecColor?.isNotEmpty ?? false) {
  //       themeSecColor = Color(int.parse("0xFF${selectedSchool?.themeSecColor?.replaceAll("#", "")}",
  //       ));
  //     } else {
  //       themeSecColor = null;
  //     }
  //   } catch (e) {
  //     themeSecColor = null;
  //     log(e.toString());
  //   }
  // }
  static const Color secondaryColor = Color(0xFFF5F7FA); // Light Gray Background
  static Color? themeMainColor;
  static Color? themeSecColor;
  static Color _mainColorYellow = const Color(0xffFBAB34);
  static Color primaryColor = Color(0xFF1F8443);
  static Color Yellow = const Color(0xffFBAB34);
  static Color _mainColorBlue = const Color(0xff132F54);
  static Color babyBlue = const Color(0xffecefff);
  static Color greenColor = const Color(0xff1d5004);
  static Color colorBlue2 = const Color(0xff0E223C);
  static Color colorBlueLight = const Color(0xffD7E2FF);
  static Color requestFieldColor = const Color(0xffEDEDED);
  static Color borderEditTextColor = const Color(0xffB9BDC0);
  static Color titleEditTextColor = const Color(0xff68696B);
  static Color whitColor = const Color(0xffffffff);
  static Color grayLightColor = const Color(0xffD9D9D9);
  static Color grayColor = const Color(0xff8d8d8d);
  static Color blackColor = const Color(0xff000000);
  static Color pinkLightColor = const Color(0xffffecf3);
  static Color pink = const Color(0xffe10154);
  static Color greenLightColor = const Color(0xffD9EADA);
  static Color yellowLightColor = const Color(0xffffeccc);
  static Color vacationRequestColor = const Color(0xffFFEDD5);
  static Color temporaryChangeOfLocationColor = const Color(0xffDFF7FF);
  static Color red = const Color(0xffd50000);
  static Color seenColor = const Color(0xff3ec9d6);

  static set mainColorBlue(value) {
    _mainColorBlue = value;
  }
  static Color get mainColorBlue {
    var main = themeMainColor;
    return main ?? _mainColorBlue;
  }
  static set mainColorYellow(value) {
    _mainColorYellow = value;
  }
  static Color get mainColorYellow {
    var main = themeSecColor;
    return main ?? _mainColorYellow;
  }

}
