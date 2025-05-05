import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';
import 'vote_sort_controller.dart';
import 'sort_model.dart';

class VotesSortScreen extends StatelessWidget {
  const VotesSortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VotesSortController>(
      init: VotesSortController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 12),
                if (controller.isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (controller.candidates.isEmpty)
                  const Expanded(
                    child: Center(child: Text("لا يوجد مرشحين متاحين")),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.candidates.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final Candidate candidate = controller.candidates[index];
                        return _buildCandidateItem(controller, candidate, index);
                      },
                    ),
                  ),
                if (controller.hasChanges)
                  _buildSaveButton(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Center(
        child: Text(
          'sort_candidates'.tr,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCandidateItem(VotesSortController controller, Candidate candidate, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              const Text("إضافة"),
              Checkbox(
                value: candidate.isSelected,
                onChanged: (_) => controller.toggleSelection(index),
                activeColor: AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const Text("شطب"),
              Checkbox(
                value: candidate.isDeleted,
                onChanged: (_) => controller.toggleSelectionDeleted(index),
                activeColor: AppColors.red,
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              candidate.name ?? "",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(VotesSortController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: controller.isSubmitting ? null : () => controller.sendToApi(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: controller.isSubmitting
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Text(
          'save'.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
