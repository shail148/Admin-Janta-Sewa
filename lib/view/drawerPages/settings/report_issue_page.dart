import 'package:admin_jantasewa/controllers/settings/report_issue_controller.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportIssuePage extends GetView<ReportIssueController> {
  const ReportIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final ReportIssueController controller = Get.find();


    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Report An Issue',
        leftIcon: Icon(Icons.arrow_back_ios, size: 24.sp), // responsive icon
        onLeftTap: Get.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(text: 'Issue Title', fontsize: 14),
            const SizedBox(height: 5),
            TextFormField(
              controller: controller.issueTitle,
              decoration: InputDecoration(
                hintText: "Unable to submit hospital admission form",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            CustomTextWidget(text: 'Type of Issue', fontsize: 14),
            const SizedBox(height: 5),
            TextFormField(
              controller: controller.issueType,
              decoration: InputDecoration(
                hintText: "123-456-7890",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            CustomTextWidget(text: 'Description of Problem', fontsize: 14),
            const SizedBox(height: 5),
            TextFormField(
              controller: controller.description,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "When I try to upload my ID proof, it shows an error message.",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            CustomTextWidget(text: 'Upload Screenshot', fontsize: 14),
            const SizedBox(height: 10),
            CustomFileUpload(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color(0xFF626262)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Get.back(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text("Cancel",
                    style: TextStyle(
                           color:  Color(0xFF626262)
                    ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.btnBgColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: controller.submitIssue,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    child: Text("Send",style: TextStyle(color: AppColors.white),),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 72),
          ],
        ),
      ),
    );
  }
}
