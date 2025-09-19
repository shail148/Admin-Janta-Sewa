import 'package:admin_jantasewa/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<void> showCustomCalendarDialog({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  DateTime selectedDate = DateTime.now();

  await Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Inter',
                color: AppColors.btnBgColor,
              ),
            ),
            const SizedBox(height: 20),
            Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AppColors.btnBgColor,
                hintColor: AppColors.btnBgColor,
                colorScheme: ColorScheme.light(primary: AppColors.btnBgColor),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
                textTheme: TextTheme(
                  bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 14),
                  bodySmall: TextStyle(fontFamily: 'Inter', fontSize: 12),
                  bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 14),
                  titleSmall: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              child: CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),

                onDateChanged: (date) {
                  selectedDate = date;
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey, fontFamily: 'Inter'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.btnBgColor,
                  ),
                  onPressed: () {
                    controller.text = DateFormat(
                      'dd/MM/yyyy',
                    ).format(selectedDate);
                    Get.back();
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(fontFamily: 'Inter', color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
