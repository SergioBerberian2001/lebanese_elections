import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';
import '../app_controller.dart';
import 'about_screen.dart';
import 'home_controller.dart';
import 'modle/voter_response_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.secondaryColor,
            drawer: _buildDrawer(context, controller),
            body: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Column(
                  children: [
                    _buildGreetingSection(context, controller),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildSearchBar(controller),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: controller.isLoading
                          ? const Center(child: CupertinoActivityIndicator())
                          : (controller.voterModelResponse?.data?.voters?.isEmpty ?? true)
                          ? Center(
                        child: Text(
                          'There is no Data'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      )
                          : RefreshIndicator(
                        color: AppColors.mainColorYellow,
                        onRefresh: () => controller.refreshData(),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (!controller.isLastPage &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent &&
                                !controller.isLoadingMore) {
                              controller.loadMoreVoters();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: controller.scrollController,
                            itemCount: (controller.voterModelResponse
                                ?.data?.voters?.length ??
                                0) +
                                (controller.isLastPage ? 0 : 1),
                            itemBuilder: (context, index) {
                                    if (index <
                                        (controller.voterModelResponse?.data
                                                ?.voters?.length ??
                                            0)) {
                                      var voter = controller.voterModelResponse
                                          ?.data?.voters?[index];
                                      return Card(
                                        color: Colors.white,
                                        elevation: 0.5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          side: BorderSide(
                                              color: Colors.grey.shade200),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 6),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      voter?.name ?? 'name'.tr,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                        '${'registration_number'.tr}: ${voter?.registrationNumber ?? "N/A"}'),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  _actionButton(
                                                    icon: Icons.check,
                                                    color: Colors.green,
                                                    onTap: () {
                                                      controller.approve(
                                                          index: index,
                                                          voterId:
                                                              voter?.id ?? 0);
                                                    },
                                                  ),
                                                  _actionButton(
                                                      icon: Icons.close,
                                                      color: Colors
                                                          .redAccent.shade100,
                                                      onTap: () =>
                                                          _showRejectReasonDialog(
                                                              controller,
                                                              index,
                                                              voter?.id ?? 0)),
                                                  _actionButton(
                                                    icon: Icons.info_outline,
                                                    color: Colors.blue,
                                                    onTap: () {
                                                      final voter = controller
                                                          .voterModelResponse
                                                          ?.data
                                                          ?.voters?[index];
                                                      if (voter != null) {
                                                        _showCandidateDetails(
                                                            voter);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Center(
                                            child:
                                                CupertinoActivityIndicator()),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100.withOpacity(0.4),
          ),
          child: Icon(icon, color: color),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, HomeController controller) {
    return Drawer(
      backgroundColor: AppColors.whitColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.whitColor,
                  backgroundImage: controller.currentUser?.avatar != null
                      ? NetworkImage(controller.currentUser!.avatar!)
                      : null,
                  child: controller.currentUser?.avatar == null
                      ? Icon(Icons.person,
                          size: 30, color: AppColors.primaryColor)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  controller.currentUser?.name ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('change_language'.tr),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  backgroundColor: Colors.white,
                  builder: (_) {
                    String currentLang = Get.locale?.languageCode ?? 'en';

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Change Language",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        _languageTile(
                          context: context,
                          title: 'English',
                          langCode: 'en',
                          countryCode: 'US',
                          isSelected: currentLang == 'en',
                        ),
                        _languageTile(
                          context: context,
                          title: 'العربية',
                          langCode: 'ar',
                          countryCode: 'AR',
                          isSelected: currentLang == 'ar',
                        ),
                      ],
                    );
                  });
            },
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('About'.tr),
              onTap: () {
                Get.to(AboutAndPrivicy(
                  isAbout: true,
                ));
              }),
          ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy'.tr),
              onTap: () {
                Get.to(AboutAndPrivicy(
                  isAbout: false,
                ));
              }),
          ListTile(
              leading: const Icon(Icons.logout),
              title: Text('logout'.tr),
              onTap: () {
                controller.logout();
              }),
        ],
      ),
    );
  }

  Widget _buildGreetingSection(
      BuildContext context, HomeController controller) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.whitColor,
            backgroundImage: controller.currentUser?.avatar != null
                ? NetworkImage(controller.currentUser!.avatar!)
                : null,
            child: controller.currentUser?.avatar == null
                ? Icon(Icons.person, size: 30, color: AppColors.primaryColor)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.currentUser?.name ?? "",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Row(
                children: [
                  Text(
                    controller.currentUser?.location ?? "",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.9)),
                  ),
                  Text(
                    ",",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.9)),
                  ),
                  Text(
                    controller.currentUser?.box ?? "",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.9)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(HomeController controller) {
    return Expanded(
      child: TextField(
        cursorColor: AppColors.primaryColor,
        onChanged: (value) {
          controller.searchCandidates(value);
        },
        decoration: InputDecoration(
          hintStyle:
              TextStyle(fontSize: Get.locale?.languageCode == "en" ? 10 : 14),
          hintText: "Search for voter name or registration number...".tr,
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          filled: true,
          fillColor: AppColors.secondaryColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _languageTile({
    required BuildContext context,
    required String title,
    required String langCode,
    required String countryCode,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: ListTile(
        title: Text(title),
        onTap: () {
          final AppController appController = Get.find<AppController>();
          appController.changeLanguage(langCode, countryCode);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showRejectReasonDialog(
      HomeController controller, int index, int typeId) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('reject_vote'.tr,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor)),
              const SizedBox(height: 16),
              TextField(
                controller: controller.reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'enter_rejection_reason'.tr,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Get.back(), child: Text("Cancel".tr)),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.reasonController.text.trim().isNotEmpty) {
                        controller.reject(index: index, voterId: typeId);
                      } else {
                        Get.snackbar(
                          'Reason is required'.tr,
                          ''.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.grey,
                          colorText: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Submit".tr),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCandidateDetails(Voters item) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.name ?? 'name'.tr,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // 🔥 لو الاسم طويل
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              _infoRow(Icons.cake_outlined,
                  '${'birthdate'.tr}: ${item.dateOfBirth ?? "-"}'),
              const SizedBox(height: 8),
              _infoRow(Icons.woman,
                  '${'mother_name'.tr}: ${item.motherName ?? "Unknown"}'),
              const SizedBox(height: 8),
              _infoRow(Icons.badge_outlined,
                  '${'registration_number'.tr}: ${item.registrationNumber ?? "N/A"}'),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Close".tr),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
