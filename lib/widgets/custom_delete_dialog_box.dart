import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteDialog {
  static void show({required VoidCallback onConfirm, VoidCallback? onCancel}) {
    Get.dialog(
      Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button (X)
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black54,
                  ),
                ),
              ),

              // Delete Icon
              const Icon(
                Icons.delete_outline,
                size: 50,
                color: AppColors.primary,
              ),

              const SizedBox(height: 12),

              // Title
              const Text(
                "Are You Sure?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                "Do you really want to delete these records?\nThis process cannot be done",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  CustomButton(
                    text: "Cancel",
                    textSize: 14,
                    textColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      if (onCancel != null) {
                        onCancel();
                      }
                      Get.back();
                    },
                  ),
                  // OutlinedButton(
                  //   style: OutlinedButton.styleFrom(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     if (onCancel != null) {
                  //       onCancel();
                  //     }
                  //     Get.back();
                  //   },
                  //   child: const Text("Cancel"),
                  // ),

                  // Delete Button
                  CustomButton(
                    text: "Delete",
                    textSize: 14,
                    onPressed: () {
                      Get.back();
                      onConfirm();
                    },
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.deepPurple,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     Get.back();
                  //     onConfirm();
                  //   },
                  //   child: const Text("Delete"),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
