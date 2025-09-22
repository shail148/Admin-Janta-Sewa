import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/file_upload.dart';
import 'package:admin_jantasewa/widgets/file_tile.dart';

class BannerTab extends StatelessWidget {
  final MediaUploadController controller;
  const BannerTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // ✅ Show form if active
      if (controller.showBannerForm.value) {
        return _BannerForm(controller: controller);
      }

      // ✅ Empty State
      if (controller.bannerFiles.isEmpty) {
        return _EmptyState(onAdd: () => controller.showBannerForm.value = true);
      }

      // ✅ List State
      return _BannerList(controller: controller);
    });
  }
}

/// ===== Empty State =====
class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "No Banners Yet",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          const Text(
            "Click below to add a banner",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          CustomButton(textSize: 14, text: "Add", onPressed: onAdd),
        ],
      ),
    );
  }
}

/// ===== Form State =====
class _BannerForm extends StatelessWidget {
  final MediaUploadController controller;
  const _BannerForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const CustomTextWidget(text: 'Upload Banner'),
          const SizedBox(height: 8),

          /// File Picker
          CustomFileUpload(
            targetFiles: controller.bannerFiles,
            title: "Upload Banner",
            subtitle: "JPG, PNG, PDF or any file",
          ),

          const SizedBox(height: 12),

          /// Show uploaded files
          Obx(
            () => Column(
              children: List.generate(
                controller.bannerFiles.length,
                (i) => FileTile(
                  file: controller.bannerFiles[i],
                  onRemove: () =>
                      controller.removeAt(controller.bannerFiles, i),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Buttons Row
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  textSize: 14,
                  text: 'Preview',
                  onPressed: () {
                    if (controller.bannerFiles.isEmpty) {
                      Get.snackbar("Error", "Please add a file first");
                      return;
                    }

                    Get.snackbar(
                      "Preview",
                      "Showing preview of selected banner",
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  textSize: 14,
                  text: 'Upload',
                  onPressed: () async {
                    final ok = await controller.submitBanner();
                    if (ok) {
                      controller.showBannerForm.value = false; // Go to list
                      Get.snackbar('Success', 'Banner uploaded');
                    } else {
                      Get.snackbar('Error', 'Please add a file before upload');
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ===== List State =====
/// ===== List State =====
class _BannerList extends StatelessWidget {
  final MediaUploadController controller;
  const _BannerList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: CustomTextWidget(text: "Uploaded Banners")),
              CustomButton(
                textSize: 14,
                text: "+ Add",
                onPressed: () => controller.showBannerForm.value = true,
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// ✅ Banner List UI
          Expanded(
            child: ListView.builder(
              itemCount: controller.bannerFiles.length,
              itemBuilder: (ctx, i) {
                final file = controller.bannerFiles[i];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      /// Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// File Name + Size
                      Expanded(
                        child: Text(
                          "${file.name} ${(file.size / (1024 * 1024)).toStringAsFixed(1)} MB",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      /// Edit Button
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 22,
                        ),
                        onPressed: () {
                          Get.snackbar(
                            "Edit",
                            "Edit ${controller.bannerFiles[i].name}",
                          );
                        },
                      ),

                      /// Delete Button
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22,
                        ),
                        onPressed: () =>
                            controller.removeAt(controller.bannerFiles, i),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
