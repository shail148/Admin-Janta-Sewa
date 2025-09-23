import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'speech_edit_page.dart';

class SpeechPreviewPage extends StatelessWidget {
  final SpeechItem speech;
  final MediaUploadController controller;

  const SpeechPreviewPage({
    super.key,
    required this.speech,
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
                speech.imagePath,
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
              "${speech.date.toLocal()}".split(' ')[0],
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
              speech.description,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
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
                      controller.speeches.remove(speech);
                      Get.back();
                      Get.snackbar("Deleted", "Speech removed");
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: "Edit",
                    textSize: 14,
                    onPressed: () {
                      Get.to(() => SpeechEditPage(
                            speech: speech,
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
