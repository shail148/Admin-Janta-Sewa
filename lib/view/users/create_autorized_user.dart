import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_drop_down.dart';
import 'package:admin_jantasewa/widgets/file_upload.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAuthorizedUserPage extends StatefulWidget {
  const CreateAuthorizedUserPage({super.key});

  @override
  State<CreateAuthorizedUserPage> createState() =>
      _CreateAuthorizedUserPageState();
}

class _CreateAuthorizedUserPageState extends State<CreateAuthorizedUserPage> {
  int currentStep = 0;

  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController postController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  String? orgType;

  void nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    } else {
      _submitForm();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _submitForm() {
    print("Name: ${nameController.text}");
    print("Mobile: ${mobileController.text}");
    print("Email: ${emailController.text}");
    print("Gender: ${genderController.text}");
    print("Address: ${addressController.text}");
    print("Org Type: $orgType");
    // yaha API call / backend submit karna hai
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Create Authorized User',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          // ===== Stepper Indicator (Icons top, text below) =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(3, (index) {
                bool isActive = currentStep >= index;

                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 2,
                              color: index == 0
                                  ? Colors.transparent
                                  : currentStep >= index
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            ),
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: isActive
                                ? AppColors.primary
                                : Colors.grey.shade300,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              color: index == 2
                                  ? Colors.transparent
                                  : currentStep > index
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        index == 0
                            ? "Personal\nDetails"
                            : index == 1
                            ? "Location\nDetails"
                            : "Authorized\nLevel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: currentStep == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: currentStep == index
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // ===== Step Content =====
          Expanded(
            child: IndexedStack(
              index: currentStep,
              children: [_personalStep(), _locationStep(), _authorizedStep()],
            ),
          ),

          // ===== Buttons =====
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: CustomButton(
                      backgroundColor: Colors.white,
                      textColor: AppColors.primary,
                      textSize: 12,
                      onPressed: previousStep,
                      text: "Back",
                    ),
                  ),
                if (currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    onPressed: nextStep,
                    text: currentStep < 2 ? "Next" : "Submit",
                    textSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Step 1: Personal Details =====
  Widget _personalStep() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        CustomLabelText(text: "Name"),
        CustomTextFormField(hintText: "Name", controller: nameController),
        CustomLabelText(text: "Mobile"),
        CustomTextFormField(hintText: "Mobile", controller: mobileController),
        CustomLabelText(text: "Email"),
        CustomTextFormField(hintText: "Email", controller: emailController),
        CustomLabelText(text: "Date of Birth"),
        CustomTextFormField(
          hintText: "Date of Birth",
          controller: nameController,
        ),
        CustomLabelText(text: "Gender"),
        CustomTextFormField(hintText: "Gender", controller: genderController),
        CustomLabelText(text: "Upload Profile Photo"),
        SizedBox(height: 8),
        CustomFileUpload(),
      ],
    );
  }

  // ===== Step 2: Location Details =====
  Widget _locationStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CustomLabelText(text: "Address"),
        CustomTextFormField(hintText: "Address", controller: addressController),
        CustomLabelText(text: "State"),
        CustomTextFormField(hintText: "State", controller: stateController),

        CustomLabelText(text: "District"),
        CustomTextFormField(hintText: "State", controller: districtController),
        CustomLabelText(text: "City / Village"),
        CustomTextFormField(
          hintText: "City / Village",
          controller: cityController,
        ),
        CustomLabelText(text: "Block"),
        CustomTextFormField(hintText: "Block", controller: blockController),
        CustomLabelText(text: "Ward Number"),
        CustomTextFormField(
          hintText: "Ward Number",
          controller: wardController,
        ),
        CustomLabelText(text: "Pin Code"),
        CustomTextFormField(
          hintText: "Pin Code",
          controller: pincodeController,
        ),
      ],
    );
  }

  // ===== Step 3: Authorized Level =====
  String? postValue;
  String? forwardedLevel;
  final List<String> roles = ["Gram Sachiv", "Ward Member", "Pradhan", "MLA"];
  Widget _authorizedStep() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CustomLabelText(text: "Post"),
        CustomDropdown(
          items: roles,
          selectedValue: postValue,
          hintText: "Select Post",
          onChanged: (val) {
            setState(() {
              postValue = val;
              int index = roles.indexOf(val!);
              if (index != -1 && index < roles.length - 1) {
                forwardedLevel = roles[index + 1];
              } else {
                forwardedLevel = null; // last value case
              }
            });
          },
        ),
        const SizedBox(height: 8),
        CustomLabelText(text: "Forwarded Level"),
        CustomDropdown(
          items: roles,
          selectedValue: forwardedLevel,
          hintText: "Select Type of Organisation",
          onChanged: (val) {
            setState(() {
              forwardedLevel = val;
            });
          },
        ),
      ],
    );
  }
}
