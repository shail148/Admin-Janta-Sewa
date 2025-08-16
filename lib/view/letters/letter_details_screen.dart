import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/colors.dart';

class LetterDetailScreen extends StatelessWidget {
  const LetterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> letter = Get.arguments;
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Complain Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.galleryBdColors,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: "Name: ${letter['applicantName']}",
                fontWeight: FontWeight.bold,
                fontsize: 14,
                color: AppColors.black,
              ),
              const SizedBox(height: 8),
              CustomTextWidget(
                text: "Mobile: ${letter['mobileNumber']}",
                fontsize: 12,
                color: AppColors.textGrey,
              ),
              const SizedBox(height: 8),
              CustomTextWidget(
                text: "Address: ${letter['address']}",
                fontsize: 12,
                color: AppColors.textGrey,
              ),
              const SizedBox(height: 8),
              CustomTextWidget(
                text: "Complain Type: ${letter['complainType']}",
                fontsize: 12,
                color: AppColors.textColor,
              ),
              const SizedBox(height: 8),
              CustomTextWidget(
                text: "Politician: ${letter['politicianName']}",
                fontsize: 12,
              ),
              CustomTextWidget(
                text: "Designation: ${letter['designation']}",
                fontsize: 12,
              ),
              const SizedBox(height: 10),
              CustomTextWidget(
                text: "Details:",
                fontWeight: FontWeight.bold,
                fontsize: 13,
                color: AppColors.black,
              ),
              CustomTextWidget(
                text: letter['briefDetail'],
                fontsize: 12,
                color: AppColors.textGrey,
              ),
              const SizedBox(height: 10),
              if (letter['uploadedFile'] != null)
                CustomTextWidget(
                  text: "Attached File: ${letter['uploadedFile']}",
                  fontsize: 12,
                  color: Colors.blue,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
