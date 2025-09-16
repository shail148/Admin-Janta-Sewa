import 'package:admin_jantasewa/controllers/contact_page_controller.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditContactPage extends StatelessWidget {
  final ContactController controller = Get.find();
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final emailCtrl = TextEditingController();
  final telephoneCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final websiteCtrl = TextEditingController();
  final social1Ctrl = TextEditingController();
  final social2Ctrl = TextEditingController();
  final social3Ctrl = TextEditingController();
  final social4Ctrl = TextEditingController();

  EditContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller.contact.value;

    // Pre-fill values
    emailCtrl.text = c.email;
    telephoneCtrl.text = c.telephone;
    mobileCtrl.text = c.mobile;
    websiteCtrl.text = c.website;
    social1Ctrl.text = c.socialLinks[0];
    social2Ctrl.text = c.socialLinks[1];
    social3Ctrl.text = c.socialLinks[2];
    social4Ctrl.text = c.socialLinks[3];

    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Edit Contact',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                CustomLabelText(text: "Email"),
                CustomTextFormField(
                  controller: emailCtrl,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!GetUtils.isEmail(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),

                // Telephone
                CustomLabelText(text: "Telephone Number"),
                CustomTextFormField(
                  controller: telephoneCtrl,
                  hintText: "Telephone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Telephone number is required";
                    }
                    return null;
                  },
                ),

                // Mobile
                CustomLabelText(text: "Mobile"),
                CustomTextFormField(
                  controller: mobileCtrl,
                  hintText: "Mobile",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile number is required";
                    }
                    if (value.length < 10) {
                      return "Enter a valid mobile number";
                    }
                    return null;
                  },
                ),

                // Website
                CustomLabelText(text: "Website"),
                CustomTextFormField(
                  controller: websiteCtrl,
                  hintText: "Website",
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Website is required";
                    }
                    // if (!value.startsWith("http")) {
                    //   return "Enter a valid URL";
                    // }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Social Links
                CustomTextWidget(
                  text: "Social Media Links",
                  fontsize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),

                CustomLabelText(text: "Facebook"),
                CustomTextFormField(
                  controller: social1Ctrl,
                  hintText: "Facebook Link",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Facebook link is required";
                    }
                    return null;
                  },
                ),

                CustomLabelText(text: "X Link"),
                CustomTextFormField(
                  controller: social2Ctrl,
                  hintText: "X Link",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "X link is required";
                    }
                    return null;
                  },
                ),

                CustomLabelText(text: "Whatsapp Group Link"),
                CustomTextFormField(
                  controller: social3Ctrl,
                  hintText: "Whatsapp Group Link",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Whatsapp group link is required";
                    }
                    return null;
                  },
                ),

                CustomLabelText(text: "Instagram"),
                CustomTextFormField(
                  controller: social4Ctrl,
                  hintText: "Instagram Link",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Instagram link is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Cancel',
                      height: 40,
                      width: 100,
                      textSize: 14,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor: AppColors.primary,
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 12),
                    CustomButton(
                      height: 40,
                      width: 100,
                      text: 'Save',
                      textSize: 14,
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.updateContact(
                            Contact(
                              email: emailCtrl.text,
                              telephone: telephoneCtrl.text,
                              mobile: mobileCtrl.text,
                              website: websiteCtrl.text,
                              socialLinks: [
                                social1Ctrl.text,
                                social2Ctrl.text,
                                social3Ctrl.text,
                                social4Ctrl.text,
                              ],
                            ),
                          );

                          CustomSnackbar.showSuccess(
                            title: "Success",
                            message: 'Your contact details have been updated',
                          );

                          // Delay navigation slightly so snackbar is visible

                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
