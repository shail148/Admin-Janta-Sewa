import 'package:admin_jantasewa/models/complaintLetter/complaint_letter_model.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintLetterDetailsPage extends StatefulWidget {
  const ComplaintLetterDetailsPage({super.key});

  @override
  State<ComplaintLetterDetailsPage> createState() =>
      _ComplaintLetterDetailsPageState();
}

class _ComplaintLetterDetailsPageState
    extends State<ComplaintLetterDetailsPage> {
  late ComplaintLetterModel complaint;

  @override
  void initState() {
    super.initState();
    complaint = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Complaint Letter',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DetailsCard(
                requestDate: complaint.date,
                idLabel: 'Complaint Letter ID',
                idValue: complaint.complaintId,
                userLabel: 'User ID',
                userValue: complaint.userId,
                reason: complaint.message,
              ),
              SizedBox(height: 8),
              if (complaint.governmentEmployee != null) ...[
                FullDetailsCard(
                  title: "Complaint of Government Employee Details",
                  details: {
                    "Applicant Name":
                        complaint.governmentEmployee!.applicantName,
                    "Mobile Number": complaint.governmentEmployee!.mobileNumber,
                    "Complaint Type":
                        complaint.governmentEmployee!.complaintType,
                    "Department Name":
                        complaint.governmentEmployee!.departmentName,
                    "Brief Detail": complaint.governmentEmployee!.briefDetail,
                  },
                ),
              ] else if (complaint.politician != null) ...[
                FullDetailsCard(
                  title: "Complaint of Politician Details",
                  details: {
                    "Applicant Name": complaint.politician!.applicantName,
                    "Mobile Number": complaint.politician!.mobileNumber,
                    "Politician Name": complaint.politician!.politicianName,
                    "Brief Detail": complaint.politician!.briefDetail,
                  },
                ),
              ] else if (complaint.nationalStateWork != null) ...[
                FullDetailsCard(
                  title: "Complaint of National/State Work Details",
                  details: {
                    "Applicant Name":
                        complaint.nationalStateWork!.applicantName,
                    "Mobile Number": complaint.nationalStateWork!.mobileNumber,
                    "Department Name":
                        complaint.nationalStateWork!.departmentName,
                    "Brief Detail": complaint.nationalStateWork!.briefDetail,
                  },
                ),
              ] else if (complaint.mpOffice != null) ...[
                FullDetailsCard(
                  title: "Complaint of MP Office Details",
                  details: {
                    "Applicant Name": complaint.mpOffice!.applicantName,
                    "Mobile Number": complaint.mpOffice!.mobileNumber,
                    "Office Type": complaint.mpOffice!.officeType,
                    "Brief Detail": complaint.mpOffice!.briefDetail,
                  },
                ),
              ],
              SizedBox(height: 16),
              CustomTextWidget(
                text: 'Upload Documents',
                fontsize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8),
              Column(
                children: complaint.uploadedDocuments.isNotEmpty
                    ? complaint.uploadedDocuments.map((doc) {
                        bool isPdf = doc.fileName.toLowerCase().endsWith(
                          '.pdf',
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: SideCustomCard(
                            child: Row(
                              children: [
                                Icon(
                                  isPdf
                                      ? Icons.picture_as_pdf
                                      : Icons.insert_drive_file,
                                  color: isPdf
                                      ? Colors.red
                                      : AppColors.btnBgColor,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: CustomTextWidget(
                                    text: "${doc.fileName} (${doc.fileSize})",
                                    fontsize: 14,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  icon: Icon(
                                    Icons.download,
                                    color: AppColors.btnBgColor,
                                  ),
                                  onPressed: () {
                                    // Implement download functionality here
                                    print("Download ${doc.fileName}");
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList()
                    : [
                        SideCustomCard(
                          child: CustomTextWidget(
                            text: 'No document uploaded',
                            fontsize: 14,
                            color: AppColors.black,
                          ),
                        ),
                      ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomForwardButton(
        onPressed: () {
          Get.toNamed('/complaintForwarding', arguments: complaint);
        },
      ),
    );
  }
}
