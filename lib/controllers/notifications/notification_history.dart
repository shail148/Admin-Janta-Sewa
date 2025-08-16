import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationsHistoryController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    // Simulating JSON data
    notifications.value = [
      {
        "title": "Water Supply Alert",
        "message":
            "Water supply will be unavailable from 10 AM to 3 PM in Zone A due to maintenance.",
        "date": "12/08/25"
      },
      {
        "title": "Public Meeting Scheduled",
        "message":
            "A Town Hall meeting is scheduled for August 8th at 6 PM in the community center.",
        "date": "11/08/25"
      },
      {
        "title": "Garbage Collection Notice",
        "message":
            "Garbage collection will be delayed by one day due to the holiday.",
        "date": "01/08/25"
      },
      {
        "title": "Weather Alert",
        "message": "Heavy rainfall expected this evening.",
        "date": "30/07/25"
      },
    ];
  }

  String formatDate(String dateString) {
    DateFormat inputFormat = DateFormat('dd/MM/yy');
    DateTime date = inputFormat.parse(dateString);

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return DateFormat('jm').format(now); // current time for today
    } else if (date == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
