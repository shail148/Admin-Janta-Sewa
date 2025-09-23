import 'dart:io';
import 'package:admin_jantasewa/controllers/image_picker_controller.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/routes/app_routes.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin_jantasewa/models/user_model.dart';

class UserEditScreen extends StatefulWidget {
  final UserModel user;

  const UserEditScreen({super.key, required this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  late TextEditingController fullName;
  late TextEditingController mobileNumber;
  late TextEditingController whatsappNumber;
  late TextEditingController email;
  late TextEditingController dob;
  late TextEditingController bloodGroup;
  late TextEditingController aadharNumber;
  late TextEditingController address;
  late TextEditingController stateCtrl;
  late TextEditingController district;
  late TextEditingController block;
  late TextEditingController vidhansabha;
  late TextEditingController cityVillage;
  late TextEditingController wardNumber;
  late TextEditingController pincode;

  final ImagePickerController imagePickerController = Get.put(
    ImagePickerController(),
  );

  @override
  void initState() {
    super.initState();

    fullName = TextEditingController(text: widget.user.name);
    mobileNumber = TextEditingController(text: widget.user.phone);
    whatsappNumber = TextEditingController(text: widget.user.phone);
    email = TextEditingController(text: widget.user.email);
    dob = TextEditingController(text: widget.user.dob);
    bloodGroup = TextEditingController(text: widget.user.gender);
    aadharNumber = TextEditingController(text: widget.user.nationality);
    address = TextEditingController(text: widget.user.address);
    stateCtrl = TextEditingController(text: widget.user.state);
    district = TextEditingController(text: widget.user.district);
    block = TextEditingController(text: widget.user.block);
    vidhansabha = TextEditingController(text: widget.user.vidhansabha);
    cityVillage = TextEditingController(text: widget.user.cityVillage);
    wardNumber = TextEditingController(text: widget.user.wardNumber);
    pincode = TextEditingController(text: widget.user.pincode);
  }

  @override
  void dispose() {
    fullName.dispose();
    mobileNumber.dispose();
    whatsappNumber.dispose();
    email.dispose();
    dob.dispose();
    bloodGroup.dispose();
    aadharNumber.dispose();
    address.dispose();
    stateCtrl.dispose();
    district.dispose();
    block.dispose();
    vidhansabha.dispose();
    cityVillage.dispose();
    wardNumber.dispose();
    pincode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Edit User',
        leftIcon: Icon(Icons.arrow_back_ios),
        onLeftTap: Get.back,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(() {
                      final File? selectedImage =
                          imagePickerController.selectedImage.value;
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.formBgColor,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage)
                            : (widget.user.profileImageUrl.isNotEmpty
                                  ? NetworkImage(widget.user.profileImageUrl)
                                        as ImageProvider
                                  : null),
                        child:
                            selectedImage == null &&
                                widget.user.profileImageUrl.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 50,
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
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildField("Full Name", fullName, "Enter Full Name"),
              _buildField("Mobile Number", mobileNumber, "Enter Mobile Number"),
              _buildField(
                "WhatsApp Number",
                whatsappNumber,
                "Enter WhatsApp Number",
              ),
              _buildField("Email", email, "Enter Email Address"),
              _buildField("Date of Birth", dob, "Enter Date of Birth"),
              _buildField(
                "Gender/Blood Group",
                bloodGroup,
                "Enter Gender or Blood Group",
              ),
              _buildField(
                "Aadhar/Nationality",
                aadharNumber,
                "Enter Aadhar or Nationality",
              ),
              _buildField("Address", address, "Enter Address"),
              _buildField("State", stateCtrl, "Enter State"),
              _buildField("District", district, "Enter District"),
              _buildField("Block", block, "Enter Block"),
              _buildField("Vidhansabha", vidhansabha, "Enter Vidhansabha"),
              _buildField("City/Village", cityVillage, "Enter City or Village"),
              _buildField("Ward Number", wardNumber, "Enter Ward Number"),
              _buildField("Pincode", pincode, "Enter Pincode"),

              const SizedBox(height: 20),
              CustomButton(
                text: 'Save'.tr,
                onPressed: _saveProfile,
                textSize: 14,
                backgroundColor: AppColors.btnBgColor,
                height: 52,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabelText(text: label),
        CustomTextFormField(
          controller: controller,
          enabled: true,
          hintText: hintText,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Pick from Gallery"),
            onTap: () {
              imagePickerController.pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take a Photo"),
            onTap: () {
              imagePickerController.pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
          if (imagePickerController.selectedImage.value != null)
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Remove Image"),
              onTap: () {
                imagePickerController.clearImage();
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }

  void _saveProfile() {
    // Update UserModel with new data
    // ignore: unused_local_variable
    final updatedUser = UserModel(
      userId: widget.user.userId,
      name: fullName.text,
      email: email.text,
      phone: mobileNumber.text,
      dob: dob.text,
      gender: bloodGroup.text, // adjust if separate field
      nationality: aadharNumber.text, // adjust if separate field
      address: address.text,
      state: stateCtrl.text,
      district: district.text,
      block: block.text,
      vidhansabha: vidhansabha.text,
      cityVillage: cityVillage.text,
      wardNumber: wardNumber.text,
      pincode: pincode.text,
      accountCreated: widget.user.accountCreated,
      lastLogin: DateTime.now().toIso8601String(),
      status: widget.user.status,
      profileImageUrl: imagePickerController.selectedImage.value != null
          ? imagePickerController.selectedImage.value!.path
          : widget.user.profileImageUrl,
    );

    // Save updatedUser to backend or local storage

    Get.snackbar(
      "Success",
      "Profile updated",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // navigate to the user detail screen
        Get.toNamed(
          AppRoutes.userDetailScreen,
          arguments: updatedUser, // pass data if needed
        );  

          //Get.back(result: updatedUser);


  }
}
