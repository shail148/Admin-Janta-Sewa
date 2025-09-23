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
      if (controller.showBannerForm.value) {
        return _BannerForm(controller: controller);
      }

      if (controller.banners.isEmpty) {
        return _EmptyState(onAdd: () => controller.showBannerForm.value = true);
      }

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
                      controller.showBannerForm.value = false;
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
class _BannerList extends StatelessWidget {
  final MediaUploadController controller;
  const _BannerList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Header row
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Banner",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF2F2A4A),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.showBannerForm.value = true,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D3270),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  "+ Add",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // List of banners
          Expanded(
            child: Obx(() {
              if (controller.banners.isEmpty) {
                return const Center(
                  child: Text(
                    "No banners uploaded yet",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.banners.length,
                itemBuilder: (ctx, i) {
                  final banner = controller.banners[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Banner Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            banner.imagePath,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // 3-dot PopupMenu
                        Positioned(
                          top: 6,
                          right: 6,
                          child: PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.white,
                            onSelected: (value) {
                              if (value == "preview") {
                                Get.snackbar(
                                  "Preview",
                                  "Preview banner ${i + 1}",
                                );
                              } else if (value == "edit") {
                                controller.showBannerForm.value = true;
                              } else if (value == "delete") {
                                controller.banners.removeAt(i);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "preview",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.visibility,
                                    color: Colors.black54,
                                  ),
                                  title: Text("Preview"),
                                ),
                              ),
                              const PopupMenuItem(
                                value: "edit",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.edit,
                                    color: Colors.black54,
                                  ),
                                  title: Text("Edit"),
                                ),
                              ),
                              const PopupMenuItem(
                                value: "delete",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
