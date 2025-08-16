import 'package:admin_jantasewa/data/notification_data.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationHistory extends StatelessWidget {
  const NotificationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // print(Get.height);
    // print(Get.width);
    return SizedBox(
      height: Get.height*0.48,
      width: Get.width,
      
      child: ListView.builder(
        itemCount: sampleNotifications.length,
        itemBuilder: (context, index) {
          
          final item = sampleNotifications[index];
          return Card(
            color: AppColors.galleryBdColors,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: item['title'],
                    fontsize: 14,
                    //fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  CustomTextWidget(
                    text: item['message'],
                    fontsize: 10,
                    color: AppColors.textGrey,
                  ),
                  const SizedBox(height: 4),
                  CustomTextWidget(
                    text: " Date: ${item['date']}",
                    fontsize: 12,
                    color: AppColors.btnBgColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
