import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/view/newsSections/gallery_preview_page.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryTab extends StatelessWidget {
  final MediaUploadController controller;
  const GalleryTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.showGalleryForm.value) {
        return _GalleryForm(controller: controller);
      }

      if (controller.galleries.isEmpty) {
        return _EmptyState(
          icon: Icons.photo_library_outlined,
          title: "No Gallery Yet",
          message: "Click below to add gallery",
          onAdd: () => controller.showGalleryForm.value = true,
        );
      }

      return _GalleryList(controller: controller);
    });
  }
}

/// ===== Empty State =====
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final VoidCallback onAdd;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          CustomButton(textSize: 14, text: "Add", onPressed: onAdd),
        ],
      ),
    );
  }
}

/// ===== Form State =====
class _GalleryForm extends StatelessWidget {
  final MediaUploadController controller;
  const _GalleryForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    final descController = TextEditingController(
      text: controller.galleryDesc.value,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const CustomTextWidget(text: "Add Description"),
          const SizedBox(height: 6),

          // Description field
          TextFormField(
            controller: descController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Describe this set (max 200)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            onChanged: (v) => controller.galleryDesc.value = v,
          ),
          const SizedBox(height: 14),

          const CustomTextWidget(text: "Upload Files"),
          const SizedBox(height: 6),

          // File uploader
          CustomFileUpload(
            targetFiles: controller.galleryFiles,
            title: "Upload Gallery Files",
            subtitle: "Images, Videos or Docs",
          ),
          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  textSize: 14,
                  text: 'Preview',
                  onPressed: () {
                    if (controller.galleryFiles.isEmpty) {
                      Get.snackbar("Error", "Please add a file first");
                      return;
                    }
                    Get.snackbar(
                      "Preview",
                      "Showing preview of selected gallery",
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
                    controller.galleryDesc.value =
                        descController.text; // ✅ sync
                    final ok = await controller.submitGallery();
                    if (ok) {
                      controller.showGalleryForm.value =
                          false; // Go back to list
                      Get.snackbar('Success', 'Gallery uploaded');
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
class _GalleryList extends StatelessWidget {
  final MediaUploadController controller;
  const _GalleryList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Uploaded Gallery",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF2F2A4A),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.showGalleryForm.value = true,
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

          // List
          Expanded(
            child: Obx(() {
              if (controller.galleries.isEmpty) {
                return const Center(
                  child: Text(
                    "No gallery uploaded yet",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.galleries.length,
                itemBuilder: (ctx, i) {
                  final g = controller.galleries[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE6E6F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.network(
                            g.imagePath,
                            width: 100,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Content
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${g.date.toLocal()}".split(' ')[0],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  g.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  g.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ✅ 3-dot menu (Popup)
                        PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onSelected: (value) {
                            if (value == "preview") {
                              Get.to(
                                () => GalleryPreviewPage(
                                  gallery: g,
                                  controller: controller,
                                ),
                              );
                            } else if (value == "edit") {
                              controller.showGalleryForm.value = true;
                            } else if (value == "delete") {
                              controller.galleries.removeAt(i);
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
                                leading: Icon(Icons.delete, color: Colors.red),
                                title: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                          icon: const Icon(Icons.more_vert, color: Colors.grey),
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
