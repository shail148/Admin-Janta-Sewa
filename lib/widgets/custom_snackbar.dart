import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    required Color backgroundColor,
    Color textColor = Colors.white,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 2),
    IconData? icon,
  }) {
    Get.snackbar( 
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      borderRadius: 12,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      duration: duration,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic, 
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 500), 
    );
  }

  static void showSuccess({required String title, required String message}) {
    show(
      title: title,
      message: message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle,
    );
  }

  static void showError({required String title, required String message}) {
    show(
      title: title,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error,
    );
  }
}
