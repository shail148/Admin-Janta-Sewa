import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class TermsOfUsePage extends StatefulWidget {
  const TermsOfUsePage({super.key});

  @override
  State<TermsOfUsePage> createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Terms of Use',
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
                      "Before Submitting Any Information, Text, Graphics, Videos, Photos, or Other Material Content to the Janta Sewa App, You Must Read and Agree to the Terms of This Submission Agreement.",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      "By submitting any content to the Janta Sewa App, you hereby agree that you are responsible for any Content that you submit and any consequences thereof.  You understand that any Content submitted on the Janta Sewa App can be removed if we believe that it violates these Terms of Service, our policies or any laws by which we are governed.  ",
                ),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      "You further agree that any information that you or other users provide to the Janta Sewa App is subject to our Privacy Policy, which governs our collection and use of information. You agree not to upload any content that infringes upon or violates copyright, trademark, privacy or any other rights of any third party, and not to attempt to circumvent any content filtering techniques we may employ. You agree to not po nude, partially nude, or sexually suggestive photos. You are responsible for any activity that occurs under your screen name. You are responsible for keeping your password secure. You must not abuse, harass, threaten, impersonate, or intimidate other users on the app. You are solely responsible for your conduct and any data, text, information, screen names, graphics, photos, profiles, audio and video clips, links Content that you submit, post, and display on the app. We may change or modify these terms, at any time, in our sole discretion",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      "You agree and acknowledge that the Janta Sewa App is not responsible for and does not control Content submitted and published by a third party. Under no circumstances will the Janta Sewa App be liable in any way for any Content, including, but not limited to, any errors or omissions in any Content, or any loss or damage of any kind incurred as a result of the use of any Content posted, emailed, transmitted or otherwise made available via the Janta Sewa App or broadcast elsewhere.  ",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  fontWeight: FontWeight.bold,
                  text:
                      "FAILURE TO ADHERE TO THE TERMS OF SERVICE AND PRIVACY POLICY, AMONG OTHERS, MAY RESULT, AMONG OTHER THINGS, IN THE TERMINATION OF YOUR ACCOUNT AND THE DELETION OF CONTENT SUBMITTED FROM YOUR ACCOUNT ON THE JANTA SEWA APP, WITH OR WITHOUT NOTICE, AS DETERMINED BY THE JANTA SEWA APP IN ITS SOLE DISCRETION. ",
                ),
                SizedBox(height: 10),
                CustomTextWidget(
                  textAlign: TextAlign.justify,
                  text:
                      "I AGREE I have read and understood all of the terms and conditions above and the Privacy Policy.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}