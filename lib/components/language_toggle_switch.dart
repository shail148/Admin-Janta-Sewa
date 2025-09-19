// ignore: file_names
// lib/components/language_toggle_switch.dart
import 'package:admin_jantasewa/controllers/language/language_controller.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageToggleSwitch extends StatelessWidget {
  final LanguageController languageController = Get.find();

  LanguageToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(
          text: 'English',
          fontsize: 12,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(width: 8),
        Obx(
          () => Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeTrackColor: AppColors.btnBgColor,
            trackOutlineColor: WidgetStateProperty.all(AppColors.btnBgColor),
            inactiveThumbColor: Colors.grey,
            value: languageController.isHindi,
            onChanged: (value) {
              languageController.toggleLanguage(value);
            },
          ),
        ),

        const SizedBox(width: 8),
        CustomTextWidget(
          text: 'हिंदी',
          fontsize: 12,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
