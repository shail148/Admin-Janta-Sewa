import 'package:admin_jantasewa/controllers/notifications/send_notification_history.dart';
import 'package:admin_jantasewa/view/notification/send_notification_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendNotificationDashboard extends StatefulWidget {
  const SendNotificationDashboard({super.key});

  @override
  State<SendNotificationDashboard> createState() =>
      _SendNotificationDashboardState();
}
class _SendNotificationDashboardState extends State<SendNotificationDashboard> {
  @override
  Widget build(BuildContext context) {
    final SendNotificationHistoryController controller = Get.put(
      SendNotificationHistoryController(),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: Obx(() {
          return ListView.separated(
            itemCount: controller.notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              var item = controller.notifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
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
                      const SizedBox(height: 6),
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
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const SendNotificationPage());
          },
          tooltip: 'Send Notification',
          backgroundColor: AppColors.bgLight,
          elevation: 6,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.btnBgColor, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.send,size: 32,color: AppColors.btnBgColor),
              //const SizedBox(width: 8),
              // const Text("Send\n Notification",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500,
              //         color: AppColors.btnBgColor)),
            ],
          ),
        ),
      ),
    );
  }
}
