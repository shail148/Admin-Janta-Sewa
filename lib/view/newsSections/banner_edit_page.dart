import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';

class BannerEditPage extends StatefulWidget {
  final BannerItem banner;
  final MediaUploadController controller;

  const BannerEditPage({
    super.key,
    required this.banner,
    required this.controller,
  });

  @override
  State<BannerEditPage> createState() => _BannerEditPageState();
}

class _BannerEditPageState extends State<BannerEditPage> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.banner.date;
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
          "Edit Banner",
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
            // Image preview
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.banner.imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Date picker
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
            const Spacer(),

            // Save button
            CustomButton(
              text: "Save Changes",
              textSize: 14,
              onPressed: () {
                final updated = BannerItem(
                  imagePath: widget.banner.imagePath,
                  date: selectedDate,
                );

                final index = widget.controller.banners.indexOf(widget.banner);
                if (index != -1) {
                  widget.controller.banners[index] = updated;
                  widget.controller.banners.refresh();
                }

                Get.back();
                Get.snackbar("Updated", "Banner updated successfully");
              },
            ),
          ],
        ),
      ),
    );
  }
}
