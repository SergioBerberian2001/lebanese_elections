import 'dart:async'; // لازم
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebanon_elections/feature/home/modle/general_response.dart';
import 'package:lebanon_elections/network/app_exception.dart';
import '../../helper/storage/local_storage_helper.dart';
import '../login/login_repository.dart';
import '../login/login_screen.dart';
import '../login/model/login_response.dart';
import 'modle/voter_response_model.dart';
import 'home_provider.dart';

class HomeController extends GetxController {
  VoterModelResponse? voterModelResponse;
  User? currentUser;
  bool isLoading = true;
  bool isLoadingMore = false;
  bool isLastPage = false;
  int currentPage = 1;
  int lastPageNumber = 1;
  String searchQuery = "";
  TextEditingController searchCandidatesController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    getVoter();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchCandidatesController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  void loadUserData() async {
    currentUser = await LocalStorageHelper.getUserData();
    update();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoading &&
        !isLastPage &&
        !isLoadingMore) {
      loadMoreVoters();
    }
  }

  void searchCandidates(String query) {
    searchQuery = query.trim();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch();
    });
  }

  void _performSearch() {
    currentPage = 1;
    isLastPage = false;
    voterModelResponse = null;
    getVoter();
  }

  void clearSearch() {
    searchQuery = "";
    searchCandidatesController.clear();
    searchCandidates("");
    update();
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _performSearch();
  }

  void getVoter() {
    isLoading = true;
    update();

    Map<String, String> body = {
      "search": searchQuery,
      "page": currentPage.toString(),
    };

    VoterRepository().getVoters(body).then((v) {
      isLoading = false;
      if (v is! AppException) {
        voterModelResponse = v;
        lastPageNumber = v?.data?.links?.lastPageNumber ?? 1;
      }
      update();
    });
  }

  void loadMoreVoters() {
    if (isLastPage) return;

    isLoadingMore = true;
    currentPage++;
    update();

    Map<String, String> body = {
      "search": searchQuery,
      "page": currentPage.toString(),
    };

    VoterRepository().getVoters(body).then((v) {
      if (v is! AppException) {
        voterModelResponse?.data?.voters?.addAll(v?.data?.voters ?? []);
        if (currentPage >= (v?.data?.links?.lastPageNumber ?? 1)) {
          isLastPage = true;
        }
      }
      isLoadingMore = false;
      update();
    });
  }

  void reject({int? index, int? voterId}) {
    Map<String, dynamic> body = {
      "voter_id": voterId?.toString(),
      "status": "2",
      "notes": reasonController.text,
    };

    VoterRepository().approveAndReject(body).then((v) {
      if (v is GeneralResponse) {
        // 🔥 ركز هنا
        Get.back();
        voterModelResponse?.data?.voters?.removeAt(index ?? 0);
        update();
        getVoter();
        reasonController.text = "";
      } else if (v is AppException) {
        Get.snackbar(
          v.message ?? "Something went wrong",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });

    update();
  }

  void approve({int? index, int? voterId}) {
    Map<String, dynamic> body = {
      "voter_id": voterId?.toString(),
      "status": "1",
      // "notes": reasonController.text,
    };

    VoterRepository().approveAndReject(body).then((v) {
      if (v is GeneralResponse) {
        voterModelResponse?.data?.voters?.removeAt(index ?? 0);
        update();
        getVoter();
      } else if (v is AppException) {
        Get.snackbar(
          v.message ?? "Something went wrong",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });

    update();
  }

  Future<void> logout() async {
    try {
      await LoginRepository().postLogout({
        "user_id": currentUser?.id.toString(),
      });
      await LocalStorageHelper.clearCredentials();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar('logout_failed'.tr, e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
