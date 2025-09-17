import 'package:admin_jantasewa/controllers/language/language_controller.dart';
import 'package:admin_jantasewa/controllers/settings/setting_controller.dart';
import 'package:admin_jantasewa/view/about_janta_sewa/privacy_policy_page.dart';
import 'package:admin_jantasewa/view/about_janta_sewa/terms_of_use_page.dart';
import 'package:admin_jantasewa/view/drawerPages/settings/report_issue_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  // find from app_binding.dart ,all controller binding present here
  final SettingsController controller = Get.find<SettingsController>();
  final LanguageController languageController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomTopAppBar(
        title: 'Setting',
        leftIcon: Icon(Icons.arrow_back_ios, size: 24.sp), // responsive icon
        onLeftTap: Get.back,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildProfileHeader(languageController),
          const SizedBox(height: 8),
          buildSectionTitle("Account Security"),
          buildButtonTile(
            "Change Password",
            Icons.lock_outline,
            onTap: () {
              // Navigate to change password screen
            },
          ),
          const SizedBox(height: 8),
          buildSectionTitle("Notification"),
          buildToggleTile(
            "Email Alerts",
            controller.emailAlerts,
            controller.toggleEmailAlerts,
            icon: Icons.email_outlined,
          ),
          buildToggleTile(
            "SMS Alerts",
            controller.smsAlerts,
            controller.toggleSmsAlerts,
            icon: Icons.sms_outlined,
          ),
          buildToggleTile(
            "Notification",
            controller.pushNotifications,
            controller.togglePushNotifications,
            icon: Icons.notifications_outlined,
          ),
          const SizedBox(height: 8),
          buildSectionTitle("Language"),
          buildLanguageToggleTile(languageController),
          const SizedBox(height: 8),
          buildSectionTitle("Support & Legal"),
          buildNavigationTile(
            "Share this app",
            Icons.share_outlined,
            onTap: () {
              // Implement share logic
            },
          ),
          buildNavigationTile(
            "Privacy policy",
            Icons.privacy_tip_outlined,
            onTap: () {
              Get.to(() => const PrivacyPolicyPage());
            },
          ),
          buildNavigationTile(
            "Terms of Use",
            Icons.warning_amber_outlined,
            onTap: () {
              Get.to(() => const TermsOfUsePage());
            },
          ),
          //  NEW SECTION: Report an Issue
          buildNavigationTile(
            "Report an issue",
            Icons.bug_report_outlined,
            onTap: () {
              // Navigate to report issue or open email
              // can  launch("mailto:support@example.com")

              Get.to(ReportIssuePage());
            },
          ),
          const SizedBox(height: 32),
          buildLogoutButton(controller),
        ],
      ),
    );
  }
}

