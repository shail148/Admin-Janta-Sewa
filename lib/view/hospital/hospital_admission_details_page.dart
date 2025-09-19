import 'package:admin_jantasewa/models/hospital/hospital_admission_model.dart';
import 'package:admin_jantasewa/view/hospital/hospital_forwording_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
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
        title: 'Hospital Admission',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsCard(
                requestDate: admission.requestDate,
                idLabel: 'ID',
                idValue: admission.userId,
                userLabel: 'User ID',
                userValue: admission.userId,
                reason: admission.reason,
              ),

              SizedBox(height: 8),
              FullDetailsCard(
                title: "Hospital Admission Details",
                details: {
                  "Patient Name": admission.patientName,
                  'Name of Attendent': admission.attendentName,
                  "Relation with Patient": admission.relationWithPatient,
                  "Disease": admission.diseaseName,
                  "Admission Type": admission.admissionType,
                  "Hospital Name": admission.hospitalName,
                  "Hospital Address": admission.hospitalAddress,
                },
              ),
              SizedBox(height: 8),
              FullDetailsCard(
                title: "Reference / Source of Request",
                details: {
                  "Name of Referee": admission.sourceName,

                  "Designation of Referee": admission.sourceDesignation,
                  "Mobile Number": admission.sourceContactNumber,
                },
              ),
              SizedBox(height: 8),
              FullDetailsCard(
                title: "Hospital Contact Person(s)",
                details: {
                  "Name": admission.hospitalContactPerson,
                  "Designation": admission.hospitalAddress,
                  "Mobile Number": admission.hospitalContactMobile,
                  "WhatsApp Number": admission.hospitalContactWhatsApp,
                },
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
