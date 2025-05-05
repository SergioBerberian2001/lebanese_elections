import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebanon_elections/feature/results/resulte_model.dart';
import 'package:lebanon_elections/feature/results/results_provider.dart';
import 'package:lebanon_elections/network/app_exception.dart';

class ResultsController extends GetxController {
  bool isLoading = true;
  ResultsModelResponse? resultsModelResponse;

  @override
  void onInit() {
    super.onInit();
    getResult();
  }

  getResult() {
    isLoading = true;
    ResultsProvider().getResults({}).then((v) {
      isLoading = false;
      update();
      if (v is AppException) {
        Get.snackbar(
          v.message ?? "",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      resultsModelResponse = v;
    });
    update();
  }
}
