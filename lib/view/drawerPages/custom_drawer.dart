import 'package:admin_jantasewa/view/auth/login_page.dart';
import 'package:admin_jantasewa/view/drawerPages/contact/contact_page.dart';
import 'package:admin_jantasewa/view/ourJourney/janta_sewa_media_screen.dart';
import 'package:admin_jantasewa/view/ourJourney/ourjourney_history_page.dart';
import 'package:admin_jantasewa/view/suggestionLetter/suggestion_allrequest_page.dart';
import 'package:admin_jantasewa/view/users/create_autorized_user.dart';
import 'package:admin_jantasewa/view/users/users_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              child: SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(radius: 30, backgroundColor: Colors.white),
                    SizedBox(height: 10),
                    CustomTextWidget(
                      text: 'Welcome Admin',
                      color: Colors.white,
                      fontsize: 12,
                    ),
                    CustomTextWidget(
                      text: 'admin@gmail.com',
                      color: Colors.white,
                      fontsize: 12,
                    ),
                  ],
                ),
              ),
            ),

            // Drawer items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(Icons.home, 'home'.tr, onTap: () {}),

                  // _drawerItem(
                  //   Icons.dashboard,
                  //   'Dashboard',
                  //   onTap: () => Get.to(() => const ServicesHomeScreen()),
                  // ),
                  _drawerItem(
                    Icons.description,
                    'Letters'.tr,
                    onTap: () {
                      Get.to(() => SuggestionLetterAllRequestPage());
                    },
                  ),
                  _drawerItem(
                    Icons.campaign,
                    'Our Journey'.tr,
                    onTap: () {
                      Get.to(() => OurjourneyHistoryPage());
                    },
                  ),
                  _drawerItem(
                    Icons.event_note,
                    'News'.tr,
                    onTap: () {
                      Get.to(() => JantaSewaMediaScreen());
                    },
                  ),

                  _drawerItem(
                    Icons.person,
                    'All Users'.tr,
                    onTap: () {
                      Get.to(() => UsersPage());
                    },
                  ),
                  _drawerItem(
                    Icons.person,
                    'Authorized Users'.tr,
                    onTap: () {
                      Get.to(() => CreateAuthorizedUserPage());
                    },
                  ),
                  _drawerItem(
                    Icons.contact_mail_outlined,
                    'Contact'.tr,
                    onTap: () {
                      Get.to(() => ContactPage());
                    },
                  ),

                  _drawerItem(Icons.settings, 'Settings'.tr, onTap: () {}),
                  _drawerItem(
                    Icons.logout,
                    'logout'.tr,
                    onTap: () {
                      Get.to(() => LoginPage());
                    },
                  ),
                ],
              ),
            ),

            // Sticky Footer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  CustomTextWidget(
                    text: '© 2025 \nDesigned and Developed by',
                    textAlign: TextAlign.center,
                    fontsize: 10,

                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('https://kasperinfotech.com/');
                      if (!await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw 'Could not launch $url';
                      }
                    },
                    child: CustomTextWidget(
                      text: 'Kasper Infotech Pvt. Ltd.',
                      color: AppColors.textColor,
                      fontsize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _drawerItem(
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 32),
      title: CustomTextWidget(text: title),
      onTap: onTap,
    );
  }
}
