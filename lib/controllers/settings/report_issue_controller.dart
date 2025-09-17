import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class ReportIssueController extends GetxController {
  final issueTitle = TextEditingController();
  final issueType = TextEditingController();
  final description = TextEditingController();

  RxList<PlatformFile> uploadedFiles = <PlatformFile>[].obs;

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      uploadedFiles.add(result.files.first);
    }
  }

  void removeFile(int index) {
    uploadedFiles.removeAt(index);
  }

  void submitIssue() {
    // Add submission logic here
    if (kDebugMode) {
      print("Title: ${issueTitle.text}");
    }
    if (kDebugMode) {
      print("Type: ${issueType.text}");
    }
    if (kDebugMode) {
      print("Description: ${description.text}");
    }
    if (kDebugMode) {
      print("Files: ${uploadedFiles.length}");
    }
  }

  @override
  void onClose() {
    issueTitle.dispose();
    issueType.dispose();
    description.dispose();
    super.onClose();
  }
}
