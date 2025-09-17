import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var emailAlerts = false.obs;
  var smsAlerts = false.obs;
  var pushNotifications = false.obs;

  /* var emailAlerts = true.obs;
  var smsAlerts = true.obs;
  var pushNotifications = true.obs; */
  //var languageToggle = false.obs; 

  

  void toggleEmailAlerts(bool value) {
    emailAlerts.value = value;
  }

  void toggleSmsAlerts(bool value) {
    smsAlerts.value = value;
  }

  void togglePushNotifications(bool value) {
    pushNotifications.value = value;
  }

  /* void toggleLanguage(bool value) {
    languageToggle.value = value;
    // You can call language change logic here via LanguageController
    
  }  */

  void logout() {
    // Implement logout logic
    if (kDebugMode) {
      print("User Logged Out");
    }
  }
}
