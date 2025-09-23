import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'banner_edit_page.dart';

class BannerPreviewPage extends StatelessWidget {
  final BannerItem banner;
  final MediaUploadController controller;

  const BannerPreviewPage({
    super.key,
    required this.banner,
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
            // ===== Banner Image =====
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                banner.imagePath,
                width: double.infinity,
                height: 200,
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
              "${banner.date.toLocal()}".split(' ')[0],
              style: const TextStyle(color: Colors.black54),
            ),
            const Spacer(),

            // ===== Buttons =====
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Delete",
                    textSize: 14,
                    onPressed: () {
                      controller.banners.remove(banner);
                      Get.back();
                      Get.snackbar("Deleted", "Banner removed");
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: "Edit",
                    textSize: 14,
                    onPressed: () {
                      Get.to(() => BannerEditPage(
                            banner: banner,
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
