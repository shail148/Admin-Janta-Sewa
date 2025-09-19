import 'package:admin_jantasewa/controllers/language/language_controller.dart';
import 'package:admin_jantasewa/controllers/settings/setting_controller.dart';
import 'package:admin_jantasewa/view/dashboard/dashboard.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';


Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: AppColors.black,
      ),
    ),
  );
}

Widget buildProfileHeader(LanguageController languageController) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFFD9D9D9)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2), // Border thickness
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFFD9D9D9),
              width: 2.0, // Border width
            ),
          ),
          child: CircleAvatar(
            radius: 28,
            //backgroundImage: AssetImage('assets/images/user_placeholder.png'),
            backgroundColor: AppColors.white, // Optional
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const DashboardPage(), arguments: {'index': 3});
                },
                child: Text(
                  "Rahul Sharma",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.black),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const DashboardPage(), arguments: {'index': 3});
                },
                child: Text(
                  "Gram Sachiv",
                  style: TextStyle(fontSize: 14, color: Color(0xFF626262)),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const DashboardPage(), arguments: {'index': 3, 'edit': true});
          },
          child: Text("Edit Profile", style: TextStyle(color: AppColors.primary)),
        ),
      ],
    ),
  );
}

Widget buildButtonTile(String title, IconData icon, {required VoidCallback onTap}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: Color(0xFFD9D9D9)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: Icon(icon, color: AppColors.black),
      title: Text(title, style: TextStyle(color: AppColors.black, fontSize: 14)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.black),
      onTap: onTap,
    ),
  );
}

Widget buildNavigationTile(String title, IconData icon, {required VoidCallback onTap}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: Color(0xFFD9D9D9)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: Icon(icon, color: AppColors.black),
      title: Text(title, style: TextStyle(color: AppColors.black, fontSize: 14)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.black),
      onTap: onTap,
    ),
  );
}

/* Original Switch version (commented) preserved */

Widget buildToggleTile(String title, RxBool value, Function(bool) onChanged, {required IconData icon}) {
  return Obx(
    () => Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFD9D9D9)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.black),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(color: AppColors.black, fontSize: 14)),
            ],
          ),
          FlutterSwitch(
            width: 42.0,
            height: 26.0,
            toggleSize: 16.0,
            value: value.value,
            borderRadius: 20.0,
            padding: 2.0,
            activeColor: AppColors.btnBgColor,
            inactiveColor: Colors.grey.shade300,
            toggleColor: AppColors.white,
            onToggle: onChanged,
          ),
        ],
      ),
    ),
  );
}

 // Language toggle
Widget buildLanguageToggleTile(LanguageController languageController) {
  return Obx(
    () => Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.language, color: AppColors.black),
              const SizedBox(width: 10),
              Text(
                "Change Language",
                style: TextStyle(color: AppColors.black, fontSize: 14),
              ),
            ],
          ),
          FlutterSwitch(
            width: 42.0,
            height: 26.0,
            toggleSize: 16.0,
            value: languageController.isHindi,
            borderRadius: 20.0,
            padding: 2.0,
            activeColor: AppColors.btnBgColor,
            inactiveColor: Colors.grey.shade300,
            toggleColor: AppColors.white,
            onToggle: (val) {
              languageController.toggleLanguage(val);
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildLogoutButton(SettingsController controller) {
  return ElevatedButton(
    onPressed: () => controller.logout(),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      minimumSize: Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: const Text("Logout", style: TextStyle(color: AppColors.white, fontSize: 16)),
  );
}
