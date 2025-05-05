import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebanon_elections/feature/home/modle/general_response.dart';
import 'package:lebanon_elections/network/app_exception.dart';

import 'sort_model.dart';
import 'vote_sort_repository.dart';

class VotesSortController extends GetxController {
  CandidateResponse? candidateResponse;
  List<Candidate> candidates = [];

  bool isLoading = true;
  bool isSubmitting = false;
  bool hasChanges = false; // 🔥

  final List<Candidate> _actionOrder = [];

  @override
  void onInit() {
    super.onInit();
    fetchCandidates();
  }

  int get maxCandidatesToSend =>
      candidateResponse?.data?.candidates?.length ?? 0;

  void fetchCandidates() {
    isLoading = true;
    update();

    VoteSortRepository().getCandidates({}).then((res) {
      isLoading = false;

      if (res is! AppException) {
        candidateResponse = res;
        candidates = res.data?.candidates ?? [];
      }

      update();
    });
  }

  void toggleSelection(int index) {
    final candidate = candidates[index];
    if (!candidate.isDeleted) {
      candidate.isSelected = !candidate.isSelected;

      // 🔥 شيل من القائمة إذا صار بدون حالة
      if (!candidate.isSelected && !candidate.isDeleted) {
        _actionOrder.removeWhere((e) => e.id == candidate.id);
      } else {
        _addOrReorder(candidate);
      }

      hasChanges = _actionOrder.isNotEmpty;
      update();
    }
  }

  void toggleSelectionDeleted(int index) {
    final candidate = candidates[index];
    if (!candidate.isSelected) {
      candidate.isDeleted = !candidate.isDeleted;

      // 🔥 شيل من القائمة إذا صار بدون حالة
      if (!candidate.isSelected && !candidate.isDeleted) {
        _actionOrder.removeWhere((e) => e.id == candidate.id);
      } else {
        _addOrReorder(candidate);
      }

      hasChanges = _actionOrder.isNotEmpty;
      update();
    }
  }



  void _addOrReorder(Candidate candidate) {
    _actionOrder.removeWhere((e) => e.id == candidate.id);
    _actionOrder.add(candidate);
  }
  void selectOffAll() {
    for (var c in candidates) {
      c.isSelected = false;
      c.isDeleted = false;
    }
    _actionOrder.clear();
    hasChanges = false;
    update();
  }

  Map<String, dynamic> generateApiBody() {
    final valid = _actionOrder
        .where((c) => c.isSelected || c.isDeleted)
        .take(maxCandidatesToSend)
        .toList();

    return {
      "candidates": valid.map((e) => e.toJson()).toList(),
    };
  }

  void sendToApi() async {
    isSubmitting = true;
    update();

    final Set<int> usedIds = {};
    final List<Map<String, dynamic>> candidatesList = [];

    for (var candidate in _actionOrder) {
      if ((candidate.isSelected || candidate.isDeleted) &&
          !usedIds.contains(candidate.id)) {
        candidatesList.add({
          "id": candidate.id,
          "status": candidate.isSelected
              ? 1
              : candidate.isDeleted
              ? 2
              : 0,
        });
        usedIds.add(candidate.id??0);
      }
    }

    final Map<String, String> body = {
      "candidates": jsonEncode(candidatesList),
    };

    VoteSortRepository().candidateAction(body).then((v) {
      isSubmitting = false;

      if (v is GeneralResponse) {
        hasChanges = false;
        fetchCandidates();
        Get.snackbar(
          v.message ?? "تمت العملية بنجاح",
          '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else if (v is AppException) {
        Get.snackbar(
          v.message ?? "حدث خطأ ما",
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
