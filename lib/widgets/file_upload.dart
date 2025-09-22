// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class CustomFileUpload extends StatefulWidget {
  final RxList<PickedFile>? targetFiles; // optional
  final String title;
  final String subtitle;

  const CustomFileUpload({
    super.key,
    this.targetFiles,
    this.title = "Upload Your Files",
    this.subtitle = "All file types allowed",
  });

  @override
  _CustomFileUploadState createState() => _CustomFileUploadState();
}

class _CustomFileUploadState extends State<CustomFileUpload> {
  RxList<PickedFile> _internalFiles = <PickedFile>[].obs;

  RxList<PickedFile> get _files =>
      widget.targetFiles ?? _internalFiles; // ✅ fallback if null

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any, // allow all file types
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      for (var file in result.files) {
        _files.add(PickedFile(file.name, file.size));
      }
    }
  }

  void removeFile(int index) {
    if (index >= 0 && index < _files.length) {
      _files.removeAt(index);
    }
  }

  Widget fileTile(PickedFile file, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.btnBgColor),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.insert_drive_file,
            color: AppColors.btnBgColor,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              file.name,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomTextWidget(
            text: '${(file.size / (1024 * 1024)).toStringAsFixed(1)} MB',
            fontsize: 12,
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: AppColors.btnBgColor,
              size: 30,
            ),
            onPressed: () => removeFile(index),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: pickFile,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.formBgColor,
              border: Border.all(color: AppColors.btnBgColor),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextWidget(text: widget.title, fontsize: 14),
                const Icon(
                  Icons.file_upload_outlined,
                  color: AppColors.btnBgColor,
                  size: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: widget.subtitle,
                      color: AppColors.textGrey,
                      fontsize: 12,
                    ),
                    const SizedBox(width: 5),
                    const CustomTextWidget(
                      text: 'Browse',
                      color: AppColors.btnBgColor,
                      fontsize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        /// show uploaded files
        Obx(
          () => Column(
            children: List.generate(
              _files.length,
              (index) => fileTile(_files[index], index),
            ),
          ),
        ),
      ],
    );
  }
}
