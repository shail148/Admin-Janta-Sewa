import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Details Screen of the Users

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'User Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 500,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.galleryBdColors,
            ),
            width: double.infinity,
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: CircleAvatar(radius: 50)),
                Divider(),
                CustomTextWidget(
                  text: 'User Information : ',
                  color: AppColors.black,
                  fontsize: 14,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                CustomTextWidget(text: "Name: ${user['name']}"),
                CustomTextWidget(text: "Email: ${user['email']}"),
                CustomTextWidget(text: "Mobile: ${user['mobile']}"),
                CustomTextWidget(text: "City: ${user['city']}"),
                CustomTextWidget(text: "State: ${user['state']}"),
                CustomTextWidget(text: "Pincode: ${user['pincode']}"),
                CustomTextWidget(text: "DOB: ${user['dob']}"),
                SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    text: 'Delete User',
                    textSize: 12,
                    onPressed: () {
                      CustomSnackbar.showSuccess(
                        title: 'Deleted',
                        message: '${user['name']} profile is Deleted',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
