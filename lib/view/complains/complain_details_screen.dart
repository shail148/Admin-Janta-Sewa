import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/constants/colors.dart';

class ComplainDetailScreen extends StatelessWidget {
  const ComplainDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> complain = Get.arguments;
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Complain Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: "Name: ${complain['applicantName']}",
                  fontWeight: FontWeight.bold,
                  fontsize: 14,
                  color: AppColors.black,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  text: "Mobile: ${complain['mobileNumber']}",
                  fontsize: 12,
                  color: AppColors.textGrey,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  text: "Address: ${complain['address']}",
                  fontsize: 12,
                  color: AppColors.textGrey,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  text: "Complain Type: ${complain['complainType']}",
                  fontsize: 12,
                  color: AppColors.textColor,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  text: "Politician: ${complain['politicianName']}",
                  fontsize: 12,
                ),
                CustomTextWidget(
                  text: "Designation: ${complain['designation']}",
                  fontsize: 12,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  text: "Details:",
                  fontWeight: FontWeight.bold,
                  fontsize: 13,
                  color: AppColors.black,
                ),
                CustomTextWidget(
                  text: complain['briefDetail'],
                  fontsize: 12,
                  color: AppColors.textGrey,
                ),
                const SizedBox(height: 8),
                if (complain['uploadedFile'] != null)
                  CustomTextWidget(
                    text: "Attached File: ${complain['uploadedFile']}",
                    fontsize: 12,
                    color: Colors.blue,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
