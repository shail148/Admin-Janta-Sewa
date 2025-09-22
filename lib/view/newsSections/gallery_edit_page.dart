import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';

class GalleryEditPage extends StatefulWidget {
  final GalleryItem gallery;
  final MediaUploadController controller;

  const GalleryEditPage({
    super.key,
    required this.gallery,
    required this.controller,
  });

  @override
  State<GalleryEditPage> createState() => _GalleryEditPageState();
}

class _GalleryEditPageState extends State<GalleryEditPage> {
  late TextEditingController descController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController(text: widget.gallery.description);
    selectedDate = widget.gallery.date;
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
          "Edit Gallery",
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
                widget.gallery.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
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
                // Update object (kyunki fields final hain -> ek naya object banana hoga)
                final updated = GalleryItem(
                  title: widget.gallery.title,
                  description: descController.text,
                  imageUrl: widget.gallery.imageUrl,
                  date: selectedDate,
                );

                // Replace in list
                final index = widget.controller.galleries.indexOf(
                  widget.gallery,
                );
                if (index != -1) {
                  widget.controller.galleries[index] = updated;
                  widget.controller.galleries.refresh();
                }

                Get.back(); // Close edit page
                Get.snackbar("Updated", "Gallery updated successfully");
              },
            ),
          ],
        ),
      ),
    );
  }
}
