import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'gallery_edit_page.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';

class GalleryPreviewPage extends StatelessWidget {
  final GalleryItem gallery;
  final MediaUploadController controller;

  const GalleryPreviewPage({
    super.key,
    required this.gallery,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "JANTA SEWA",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF3D3270),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Uploaded Image =====
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                gallery.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // ===== Date =====
            const Text(
              "Date",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${gallery.date.toLocal()}".split(' ')[0],
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // ===== Description =====
            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              gallery.description,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const Spacer(),

            // ===== Delete & Edit Buttons =====
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Delete",
                    textSize: 14,
                    onPressed: () {
                      controller.galleries.remove(gallery);
                      Get.back();
                      Get.snackbar("Deleted", "Gallery item removed");
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: "Edit",
                    textSize: 14,
                    onPressed: () {
                      Get.to(() => GalleryEditPage(
                            gallery: gallery,
                            controller: controller,
                          ));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
