// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CustomFileUpload extends StatefulWidget {
  @override
  _CustomFileUploadState createState() => _CustomFileUploadState();
}

class _CustomFileUploadState extends State<CustomFileUpload> {
  List<PlatformFile> uploadedFiles = [];

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        uploadedFiles.add(result.files.first);
      });
    }
  }

  void removeFile(int index) {
    setState(() {
      uploadedFiles.removeAt(index);
    });
  }

  Widget fileTile(PlatformFile file, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.btnBgColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.insert_drive_file, color: AppColors.btnBgColor, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              file.name,
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomTextWidget(
            text: '${(file.size / (1024 * 1024)).toStringAsFixed(1)} MB',
            fontsize: 12,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: AppColors.btnBgColor, size: 30),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.formBgColor,
              border: Border.all(
                color: AppColors.btnBgColor,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextWidget(text: 'Upload Your Files', fontsize: 14),
                  SizedBox(height: 5),
                  Icon(
                    Icons.file_upload_outlined,
                    color: AppColors.btnBgColor,
                    size: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidget(
                        text: 'in JPG, PNG, PDF',
                        color: AppColors.textGrey,
                        fontsize: 12,
                      ),
                      SizedBox(width: 5),
                      CustomTextWidget(
                        text: 'Browse',
                        color: AppColors.btnBgColor,
                        fontsize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  // CustomTextWidget(text: 'in JPG, PNG, PDF',fontsize: 12,),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(
            uploadedFiles.length,
            (index) => fileTile(uploadedFiles[index], index),
          ),
        ),
      ],
    );
  }
}
