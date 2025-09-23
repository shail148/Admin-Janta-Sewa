import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/file_upload.dart';

class SpeechTab extends StatelessWidget {
  final MediaUploadController controller;
  const SpeechTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.showSpeechForm.value) {
        return _SpeechForm(controller: controller);
      }

      if (controller.speeches.isEmpty) {
        return _EmptyState(
          icon: Icons.speaker_notes_outlined,
          title: "No Speeches Yet",
          message: "Click below to add a speech",
          onAdd: () => controller.showSpeechForm.value = true,
        );
      }

      return _SpeechList(controller: controller);
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
class _SpeechForm extends StatelessWidget {
  final MediaUploadController controller;
  const _SpeechForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(
      text: controller.addressedBy.value,
    );
    final descController = TextEditingController(
      text: controller.speechDesc.value,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const CustomTextWidget(text: "Addressed by"),
          const SizedBox(height: 6),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            onChanged: (v) => controller.addressedBy.value = v,
          ),
          const SizedBox(height: 14),

          const CustomTextWidget(text: "Add Description"),
          const SizedBox(height: 6),
          TextFormField(
            controller: descController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Add description (max 200)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            onChanged: (v) => controller.speechDesc.value = v,
          ),
          const SizedBox(height: 14),

          const CustomTextWidget(text: "Upload Files"),
          const SizedBox(height: 6),
          CustomFileUpload(
            targetFiles: controller.speechFiles,
            title: "Upload Speech Files",
            subtitle: "Audio, Video or Docs",
          ),
          const SizedBox(height: 20),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  textSize: 14,
                  text: 'Preview',
                  onPressed: () {
                    if (controller.speechFiles.isEmpty) {
                      Get.snackbar("Error", "Please add a file first");
                      return;
                    }
                    Get.snackbar(
                      "Preview",
                      "Showing preview of selected speech files",
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  textSize: 14,
                  text: "Upload",
                  onPressed: () async {
                    controller.addressedBy.value = nameController.text;
                    controller.speechDesc.value = descController.text;

                    final ok = await controller.submitSpeech();
                    if (ok) {
                      controller.showSpeechForm.value = false; // Go to list
                      Get.snackbar('Success', 'Speech uploaded');
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please fill details & add at least 1 file',
                      );
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
class _SpeechList extends StatelessWidget {
  final MediaUploadController controller;
  const _SpeechList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header row
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Speeches",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF2F2A4A),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.showSpeechForm.value = true,
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

          // Uploaded list
          Expanded(
            child: Obx(() {
              if (controller.speeches.isEmpty) {
                return const Center(
                  child: Text(
                    "No speeches uploaded yet",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.speeches.length,
                itemBuilder: (ctx, i) {
                  final speech = controller.speeches[i];
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
                            speech.imagePath,
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
                                  "${speech.date.toLocal()}".split(' ')[0],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  speech.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  speech.description,
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

                        // 3-dot Popup Menu
                        PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onSelected: (value) {
                            if (value == "preview") {
                              Get.snackbar(
                                "Preview",
                                "Preview speech ${i + 1}",
                              );
                            } else if (value == "edit") {
                              controller.showSpeechForm.value = true;
                            } else if (value == "delete") {
                              controller.speeches.removeAt(i);
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
