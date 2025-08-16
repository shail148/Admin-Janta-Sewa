import 'package:admin_jantasewa/controllers/image_picker_controller.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/date_picker.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ProfileScreen extends StatelessWidget {
  final isEditing = false.obs;
  final fullName = TextEditingController(text: "Admin");
  final mobileNumber = TextEditingController(text: "9876545678");
  final whatsappNumber = TextEditingController(text: "9876543210");
  final email = TextEditingController(text: "admin@gmail.com");
  final dob = TextEditingController(text: "2003-01-01");
  final bloodGroup = TextEditingController(text: "O+");
  final aadharNumber = TextEditingController(text: "1234-5678-9012");
  final address = TextEditingController(text: "123, Main Street");
  final stateCtrl = TextEditingController(text: "Uttar Pradesh");
  final district = TextEditingController(text: "Noida");
  final block = TextEditingController(text: "Block A");
  final vidhansabha = TextEditingController(text: "Noida Central");
  final cityVillage = TextEditingController(text: "Noida");
  final wardNumber = TextEditingController(text: "15");
  final pincode = TextEditingController(text: "201301");

final ImagePickerController imagePickerController = Get.put(ImagePickerController());
  ProfileScreen({super.key});

  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo,),
            title: const Text('Pick from Gallery'),
            onTap: () {
              imagePickerController.pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () {
              imagePickerController.pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          if (imagePickerController.selectedImage.value != null)
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Remove Image'),
              onTap: () {
                imagePickerController.clearImage();
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  void saveProfile() {
    toggleEdit();
    Get.snackbar(
      'Success',
      'Profile updated',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(() {
                          final selectedImage = imagePickerController.selectedImage.value;
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.btnBgColor,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                              color: AppColors.formBgColor,
                              image: selectedImage != null
                                  ? DecorationImage(
                                      image: FileImage(selectedImage),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: selectedImage == null
                                ? Icon(
                                    Icons.person,
                                    size: 40,
                                    color: AppColors.btnBgColor,
                                  )
                                : null,
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => _showImageSourceOptions(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.btnBgColor,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      CustomTextWidget(
                        text: 'personal_details'.tr,
                        color: AppColors.textColor,
                        fontsize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      Obx(() => CustomLabelText(
                            text: isEditing.value ? 'Editing'.tr : 'Edit'.tr,
                            color: isEditing.value ? Colors.green : AppColors.textColor,
                          )),
                      IconButton(
                        icon: Icon(
                          isEditing.value ? Icons.close : Icons.edit,
                          color: isEditing.value ? Colors.red : AppColors.btnBgColor,
                        ),
                        onPressed: toggleEdit,
                        tooltip: isEditing.value ? 'Cancel Edit' : 'Edit Profile',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // FORM FIELDS
                  CustomLabelText(text: 'full_name'.tr),
                  CustomTextFormField(
                    hintText: 'enter_full_name'.tr,
                    controller: fullName,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'mobile_number'.tr),
                  CustomTextFormField(
                    hintText: 'enter_mobile_number'.tr,
                    controller: mobileNumber,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'whatsapp_number'.tr),
                  CustomTextFormField(
                    hintText: 'enter_whatsapp_number'.tr,
                    controller: whatsappNumber,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'email_id'.tr),
                  CustomTextFormField(
                    hintText: 'enter_email_id'.tr,
                    controller: email,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'date_of_birth'.tr),
                  CustomTextFormField(
                    hintText: 'dob_hint'.tr,
                    controller: dob,
                    suffixIcon: Icons.calendar_month,
                    suffixIconColor: AppColors.btnBgColor,
                    onSuffixTap: () {
                      showCustomCalendarDialog(context: context, controller: dob);
                    },
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'blood_group'.tr),
                  CustomTextFormField(
                    hintText: 'enter_blood_group'.tr,
                    controller: bloodGroup,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'aadhar_number'.tr),
                  CustomTextFormField(
                    hintText: 'enter_aadhar_number'.tr,
                    controller: aadharNumber,
                    enabled: isEditing.value,
                  ),
                  const SizedBox(height: 10),
                  CustomTextWidget(
                    text: 'location_details'.tr,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                    fontsize: 16,
                  ),
                  const SizedBox(height: 10),
                  CustomLabelText(text: 'address'.tr),
                  CustomTextFormField(
                    hintText: 'enter_address'.tr,
                    controller: address,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'state'.tr),
                  CustomTextFormField(
                    hintText: 'enter_state'.tr,
                    controller: stateCtrl,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'district'.tr),
                  CustomTextFormField(
                    hintText: 'enter_district'.tr,
                    controller: district,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'block'.tr),
                  CustomTextFormField(
                    hintText: 'enter_block'.tr,
                    controller: block,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'vidhansabha'.tr),
                  CustomTextFormField(
                    hintText: 'enter_vidhansabha'.tr,
                    controller: vidhansabha,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'city_village'.tr),
                  CustomTextFormField(
                    hintText: 'enter_city_village'.tr,
                    controller: cityVillage,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'ward_number'.tr),
                  CustomTextFormField(
                    hintText: 'enter_ward_number'.tr,
                    controller: wardNumber,
                    enabled: isEditing.value,
                  ),
                  CustomLabelText(text: 'pincode'.tr),
                  CustomTextFormField(
                    hintText: 'enter_pincode'.tr,
                    controller: pincode,
                    enabled: isEditing.value,
                  ),
                  const SizedBox(height: 20),

                  if (isEditing.value)
                    CustomButton(
                      text: 'Save'.tr,
                      textSize: 14,
                      backgroundColor: AppColors.btnBgColor,
                      height: 52,
                      width: double.infinity,
                      onPressed: saveProfile,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
