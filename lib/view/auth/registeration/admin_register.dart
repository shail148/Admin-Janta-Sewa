// ignore_for_file: unused_import

import 'package:admin_jantasewa/components/custom_dropdown.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthorizedPersonRegister extends StatefulWidget {
  const AuthorizedPersonRegister({super.key});

  @override
  State<AuthorizedPersonRegister> createState() =>
      _AuthorizedPersonRegisterState();
}

class _AuthorizedPersonRegisterState extends State<AuthorizedPersonRegister> {
  final List<String> typesAuth = [
    'MP Representative',
    'Organization Official',
    'Elected Political Member',
  ];
  String? selectTypesAuth;
  final List<String> authorizeArea = [
    'college',
    'Schools',
    'Municipal Corporations',
    'Municipal Councils',
    'Legislative Assemblies',
    'Other public institutions',
  ];
  String? selectedOrg;
  final List<String> orgAppointedOfficials = [
    'district'.tr,
    'assembly'.tr,
    'mandal'.tr,
    'shakti_kendra'.tr,
  ];
  final List<String> members = [
    'janpad_panchayat_member'.tr,
    'zila_panchayat_member'.tr,
    'nagar_panchayat_'.tr,
    'municipal_corporation_level'.tr,
  ];
  String? selectMember;
  String? selectOrgAppointedOfficials;
  final List<String> areaWiseRights = [
    'ward'.tr,
    'gram_panchayat'.tr,
    'blocks'.tr,
    'assemblies'.tr,
  ];
  String? selectAreaRights;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          // thickness: 5,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            child: SafeArea(
              
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                         CustomTextWidget(
                            text: "auth_person_registration".tr,
                            color: AppColors.textColor,
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 10),
                          CustomLabelText(text: 'full_name'.tr),
                          CustomTextFormField(hintText: 'enter_full_name'.tr),
                          CustomLabelText(text: 'contact_number'.tr),
                          CustomTextFormField(
                            hintText: 'enter_contact_number'.tr,
                          ),
                          CustomLabelText(text: 'email_id'.tr),
                          CustomTextFormField(hintText: 'enter_email_id'.tr),
                          SizedBox(height: 10),
                          CustomLabelText(text: 'types_of_auth'.tr),
        
                          CustomDropdown(
                            items: typesAuth,
                            selectedValue: typesAuth.contains(selectTypesAuth) ? selectTypesAuth : null,
                            onChanged: (value) {
                              setState(() {
                                selectTypesAuth = value;
                              });
                            },
                          ),
        
                          SizedBox(height: 10),
                          CustomLabelText(text: 'authorised_areas'.tr),
                          CustomDropdown(
                            items: authorizeArea,
                            selectedValue: authorizeArea.contains(selectedOrg) ? selectedOrg : null,
                            onChanged: (value) {
                              setState(() {
                                selectedOrg = value;
                              });
                            },
                            label: 'authorised_areas'.tr,
                          ),
                          SizedBox(height: 10),
                          CustomLabelText(text: 'org_appointed_officials'.tr),
                          CustomDropdown(
                            items: orgAppointedOfficials,
                            selectedValue: orgAppointedOfficials.contains(selectOrgAppointedOfficials) ? selectOrgAppointedOfficials : null,
                            onChanged: (value) {
                              setState(() {
                                selectOrgAppointedOfficials = value;
                              });
                            },
                            label: 'org_appointed_officials'.tr,
                          ),
        
                          SizedBox(height: 10),
                          CustomLabelText(text: 'members'.tr),
                          CustomDropdown(
                            items: members,
                            selectedValue: members.contains(selectMember) ? selectMember : null,
                            onChanged: (value) {
                              setState(() {
                                selectMember = value;
                              });
                            },
                          ),
        
                          SizedBox(height: 10),
                          CustomLabelText(text: 'type_of_rights'.tr),
                          CustomTextFormField(
                            hintText: 'enter_types_of_rights'.tr,
                          ),
                          CustomLabelText(text: 'select_area_wise_rigths'.tr),
                          CustomDropdown(
                            items: areaWiseRights,
                            selectedValue: areaWiseRights.contains(selectAreaRights) ? selectAreaRights : null,
                            onChanged: (value) {
                              setState(() {
                                selectAreaRights = value;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 30,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              CustomTextWidget(
                                text: 'information'.tr,
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 241, 240, 240),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextWidget(
                                text: 'after_register_info'.tr,
                                fontsize: 12,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomButton(
                            text: 'submit_btn'.tr,
                            textSize: 14,
                            backgroundColor: AppColors.btnBgColor,
                            height: 62,
                            width: double.infinity,
                            onPressed: () {
                              //add a login logic
                              // Get.to(()=>BottomNav());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
