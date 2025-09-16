import 'package:admin_jantasewa/models/complaintLetter/complaint_letter_model.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintForwardingPage extends StatelessWidget {
  const ComplaintForwardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ComplaintLetterModel complaint = Get.arguments;
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Forward Complaint Letter',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsCard(
              requestDate: complaint.date,
              idLabel: 'Complaint Letter ID',
              idValue: complaint.complaintId,
              userLabel: 'User ID',
              userValue: complaint.userId,
              reason: complaint.message,
            ),
            SizedBox(height: 16),
            CustomTextWidget(
              text: 'Forward to:',
              fontsize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Department/Officer Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            CustomTextWidget(
              text: 'Remarks:',
              fontsize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 8),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Add remarks',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.btnBgColor,
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () {
                // Implement forwarding logic here
                Get.back();
              },
              child: Text('Forward', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
