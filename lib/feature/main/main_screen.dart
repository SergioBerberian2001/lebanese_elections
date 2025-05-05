import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
 import '../../constant/app_colors.dart';
import '../home/home_screen.dart';
import '../notes/notes_screen.dart';
import '../results/results_screen.dart';
import '../sort/votes_sort_screen.dart';
import 'main_controller.dart';

class MainScreen extends StatelessWidget {
    MainScreen({super.key});

  final List<Widget> _pages =   [
    HomeScreen(),
    VotesSortScreen(),
    ResultsScreen(),
    NotesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return PersistentTabView(
      padding: EdgeInsets.zero,
      context,
      controller: controller.persistentTabController,
      screens: _pages,
      items: _buildNavBarItems(controller),
      backgroundColor: Colors.transparent,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }

  List<PersistentBottomNavBarItem> _buildNavBarItems(MainController controller) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_pin_outlined),
        title: 'deletion_regulations'.tr,
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        onPressed: (BuildContext? context) => controller.changeTab(0),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: 'vote_sort'.tr,
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        onPressed: (BuildContext? context) => controller.changeTab(1),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.data_exploration_outlined),
        title: 'results'.tr,
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        onPressed: (BuildContext? context) => controller.changeTab(2),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.note_sharp),
        title: 'notes'.tr,
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
        onPressed: (BuildContext? context) => controller.changeTab(3),
      ),
    ];
  }
}
