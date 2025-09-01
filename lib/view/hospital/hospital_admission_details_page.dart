import 'package:admin_jantasewa/models/hospital/hospital_admission_model.dart';
import 'package:admin_jantasewa/view/hospital/hospital_forwording_page.dart';
import 'package:admin_jantasewa/widgets/custom_info_row.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalAdmissionDetailsPage extends StatefulWidget {
  const HospitalAdmissionDetailsPage({super.key});

  @override
  State<HospitalAdmissionDetailsPage> createState() =>
      _HospitalAdmissionDetailsPageState();
}

class _HospitalAdmissionDetailsPageState
    extends State<HospitalAdmissionDetailsPage> {
  late HospitalAdmissionModel admission;

  @override
  void initState() {
    super.initState();
    admission = Get.arguments; // load ticket from Get.arguments
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Hospital Admission Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF356CC5),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color(0xFFD9D9D9)),
                ),
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.btnBgColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: CustomTextWidget(
                        text: admission.requestId,
                        fontsize: 14,
                        color: AppColors.btnBgColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.perm_identity_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            //Profile Showing Logic
                            CustomSnackbar.showSuccess(
                              title: 'Profile',
                              message:
                                  'Showing profile for user: ${admission.userId}',
                            );
                          },
                          child: CustomTextWidget(
                            text: 'ID : ${admission.userId}',
                            fontsize: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.chat, size: 20, color: Colors.white),
                        SizedBox(width: 8),
                        Expanded(
                          child: CustomTextWidget(
                            text: 'Message : ${admission.reason}',
                            fontsize: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              CustomTextWidget(
                text: 'Hospital Admission Details',
                fontsize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8),
              CustomInfoRow(
                label: 'Patient Name',
                value: admission.patientName,
              ),
              CustomInfoRow(
                label: 'Name of Attendent',
                value: admission.attendentName,
              ),
              CustomInfoRow(
                label: 'Relation with Patient',
                value: admission.relationWithPatient,
              ),
              CustomInfoRow(label: 'Diease', value: admission.diseaseName),
              CustomInfoRow(
                label: 'Admission Type',
                value: admission.admissionType,
              ),
              CustomInfoRow(
                label: 'Hospital Name',
                value: admission.hospitalName,
              ),
              CustomInfoRow(
                label: 'Hospital Address',
                value: admission.hospitalAddress,
              ),
              SizedBox(height: 16),
              CustomTextWidget(
                text: 'Reference / Source of Request',
                fontsize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8),

              CustomInfoRow(
                label: 'Name of Source',
                value: admission.sourceName,
              ),
              CustomInfoRow(
                label: 'Designation of Reference',
                value: admission.sourceDesignation,
              ),
              CustomInfoRow(
                label: 'Mobile Number',
                value: admission.sourceContactNumber,
              ),
              SizedBox(height: 16),
              CustomTextWidget(
                text: 'Hospital Contact Person(s)',
                fontsize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8),
              CustomInfoRow(
                label: 'Name',
                value: admission.hospitalContactPerson,
              ),
              CustomInfoRow(
                label: 'Designation',
                value: admission.hospitalContactMobile,
              ),
              CustomInfoRow(
                label: 'Mobile Number',
                value: admission.hospitalContactMobile,
              ),

              CustomInfoRow(
                label: 'WhatsApp Number',
                value: admission.hospitalContactWhatsApp,
              ),
              SizedBox(height: 16),
              CustomTextWidget(
                text: 'Upload Documents',
                fontsize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8),
              SideCustomCard(
                child: Row(
                  children: [
                    Icon(Icons.file_present, color: AppColors.btnBgColor),
                    SizedBox(width: 8),
                    Expanded(
                      child: CustomTextWidget(
                        text: admission.uploadedDocument.isNotEmpty
                            ? admission.uploadedDocument
                            : 'No document uploaded',
                        fontsize: 14,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.download, color: AppColors.btnBgColor),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomForwardButton(
        onPressed: () {
          Get.to(() => HospitalForwordingPage());
        },
      ),
    );
  }
}
