import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Privacy Policy',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () {
          Get.back();
        },
      ),
      body: Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  fontWeight: FontWeight.w600,
                  text:
                      "Collaboration, community-building, and citizen engagement are the key pillars of the Janta Sewa App (“App”). This is a one-of-its-kind initiative powered by public representatives, volunteers, and grassroots participants. You are joining a vibrant community of citizens dedicated to public service and development.",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      "Through this App, you can stay connected with your elected representative, contribute to public welfare activities, and engage with communities focused on local governance, social causes, and youth empowerment. The App keeps you informed about government programs, constituency-level initiatives, and developmental achievements. You can also connect with fellow volunteers, participate in events, and contribute to various movements and surveys relevant to your region",
                ),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  fontWeight: FontWeight.bold,
                  text: "Privacy Policy",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      "This Privacy Policy explains what data we collect, why we collect it, and how we use it. By downloading and using the App, you acknowledge and accept the contents of this Privacy Policy and any future updates.",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  fontWeight: FontWeight.bold,
                  text: "Data Collection",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      "To offer a personalized experience, the App may process the information you share with us. We may also use secure third-party services for analytics and personalization purposes. This helps us deliver content in your preferred language and based on your interests or location.Example: Based on your location, the App may notify you when your MLA is visiting your area or when a local event is taking place. Based on past activity in the App, you may receive updates and alerts aligned to your interests.",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'Transparency & Choice',
                  fontWeight: FontWeight.bold,
                ),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      'You may choose which permissions to allow, and can continue using many features with limited access.',
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'Data Deletion',
                  fontWeight: FontWeight.bold,
                ),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      'If you wish to delete your personal data,please email us atsupport@jantasewaapp.in. We will respond within 48 hours.',
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'User Safety & Security',
                  fontWeight: FontWeight.bold,
                ),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      'We value your privacy. Your information is never sold or rented and is used only for the App’s functions. We take all reasonable steps to secure your data.',
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  text: 'Contact Us',
                  fontWeight: FontWeight.bold,
                ),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      'For any questions or feedback regarding this policy, please use the Help & Feedback section in the App.',
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
