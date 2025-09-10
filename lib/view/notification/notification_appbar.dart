// ignore: file_names
import 'package:admin_jantasewa/controllers/notifications/notification_history.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationAppbarPage extends StatefulWidget {
  const NotificationAppbarPage({super.key});

  @override
  State<NotificationAppbarPage> createState() => _NotificationAppbarPageState();
}

class _NotificationAppbarPageState extends State<NotificationAppbarPage> {
  final NotificationsHistoryController controller = Get.put(
    NotificationsHistoryController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Notifications',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          return ListView.separated(
            itemCount: controller.notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              var item = controller.notifications[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey,
                  //     spreadRadius: 1,
                  //     blurRadius: 4,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomTextWidget(
                      text: item['title'],
                      fontWeight: FontWeight.bold,
                    ),

                    const SizedBox(height: 4),

                    // Message
                    CustomTextWidget(
                      text: item['message'],
                      fontsize: 12,
                      textAlign: TextAlign.start,
                    ),

                    // Date
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        controller.formatDate(item['date']),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
