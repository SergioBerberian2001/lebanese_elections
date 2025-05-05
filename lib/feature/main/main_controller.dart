import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../sort/vote_sort_controller.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  // Add the PersistentTabController here
  late PersistentTabController persistentTabController;

  @override
  void onInit() {
    super.onInit();
    persistentTabController =
        PersistentTabController(initialIndex: currentIndex.value);
  }

  void changeTab(int index) {
    currentIndex.value = index;
    persistentTabController.index = index; // Update the tab index
  }
}
