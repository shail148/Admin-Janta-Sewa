import 'package:admin_jantasewa/data/notification_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationController extends GetxController {
  var title = ''.obs;
  var message = ''.obs;

  RxList<Map<String, String>> notificationList = <Map<String, String>>[].obs;

  void sendNotification() {
    if (title.isNotEmpty && message.isNotEmpty) {
      final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      sampleNotifications.add({
        'title': title.value,
        'message': message.value,
        'date': currentDate,
      });

      // Clear inputs
      title.value = '';
      message.value = '';

      Get.snackbar('Success', 'Notification sent & saved');
    } else {
      Get.snackbar('Error', 'Title and Message are required');
    }
  }
}
