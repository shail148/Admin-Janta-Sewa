import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';

class SpeechEditPage extends StatefulWidget {
  final SpeechItem speech;
  final MediaUploadController controller;

  const SpeechEditPage({
    super.key,
    required this.speech,
    required this.controller,
  });

  @override
  State<SpeechEditPage> createState() => _SpeechEditPageState();
}

class _SpeechEditPageState extends State<SpeechEditPage> {
  late TextEditingController descController;
  late TextEditingController titleController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.speech.title);
    descController = TextEditingController(text: widget.speech.description);
    selectedDate = widget.speech.date;
  }

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
          "Edit Speech",
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
            // ===== Image Preview =====
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.speech.imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // ===== Title =====
            const Text(
              "Addressed by",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter name/title",
              ),
            ),
            const SizedBox(height: 16),

            // ===== Date Picker =====
            const Text(
              "Date",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ===== Description =====
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter description",
              ),
            ),
            const Spacer(),

            // ===== Save Button =====
            CustomButton(
              text: "Save Changes",
              textSize: 14,
              onPressed: () {
                final updated = SpeechItem(
                  title: titleController.text,
                  description: descController.text,
                  imagePath: widget.speech.imagePath,
                  date: selectedDate,
                );

                final index = widget.controller.speeches.indexOf(widget.speech);
                if (index != -1) {
                  widget.controller.speeches[index] = updated;
                  widget.controller.speeches.refresh();
                }

                Get.back();
                Get.snackbar("Updated", "Speech updated successfully");
              },
            ),
          ],
        ),
      ),
    );
  }
}
