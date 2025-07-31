// lib/controller/language_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  // Reactive language state
  Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  void toggleLanguage(bool isHindi) {
    currentLocale.value = isHindi
        ? const Locale('hi', 'IN')
        : const Locale('en', 'US');
    Get.updateLocale(currentLocale.value);
  }
  bool get isHindi => currentLocale.value.languageCode == 'hi';
}
