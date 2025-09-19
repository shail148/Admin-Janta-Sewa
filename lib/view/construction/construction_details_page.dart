import 'package:admin_jantasewa/models/construction/construction_model.dart';
import 'package:admin_jantasewa/view/construction/construction_forward_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstructionDetailsPage extends StatefulWidget {
  const ConstructionDetailsPage({super.key});

  @override
  State<ConstructionDetailsPage> createState() =>
      _ConstructionDetailsPageState();
}

class _ConstructionDetailsPageState extends State<ConstructionDetailsPage> {
  late ConstructionWorkModel construction;

  @override
  void initState() {
    super.initState();
    construction = Get.arguments; // load ticket from Get.arguments
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Construction Details',
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
                requestDate: construction.date,
                idLabel: 'ID',
                idValue: construction.workId,
                userLabel: 'User ID',
                userValue: construction.userId,

                reason: construction.message,
              ),

              SizedBox(height: 8),
              FullDetailsCard(
                title: "Invitation Details",
                details: {
                  "Date": construction.date,
                  "Work ID": construction.workId,
                  "User ID": construction.userId,
                },
              ),
              SizedBox(height: 8),
              if (construction.newWork != null) ...[
                FullDetailsCard(
                  title: "New Work Demand Details",
                  details: {
                    "Work By": construction.newWork!.workBy,
                    "Work Detail": construction.newWork!.workDetail,
                    "Tentative Amount": construction.newWork!.tentativeAmount,
                    "Remark": construction.newWork!.remark,
                    "Contact Person":
                        construction.newWork!.contact.demandedPerson,
                    "Mobile Number": construction.newWork!.contact.mobileNumber,
                  },
                ),
              ] else if (construction.pending != null) ...[
                FullDetailsCard(
                  title: "Pending Work Completion Details",
                  details: {
                    "Work By": construction.pending!.workBy,
                    "Work Detail": construction.pending!.workDetail,
                    "Actual Amount": construction.pending!.actualAmount,

                    "Demanded Person":
                        construction.pending!.contact.demandedPerson,

                    "Remark": construction.pending!.remark,
                  },
                ),
              ] else if (construction.beneficiary != null) ...[
                FullDetailsCard(
                  title: "Beneficiary Oriented Details",
                  details: {
                    "Work By": construction.beneficiary!.workBy,
                    "Department Name": construction.beneficiary!.departmentName,
                    "Amount": construction.beneficiary!.amount,

                    "Demanded Person":
                        construction.beneficiary!.contact.demandedPerson,
                    "Mobile Number":
                        construction.beneficiary!.contact.mobileNumber,
                    "Remark": construction.beneficiary!.remark,
                  },
                ),
              ],
              SizedBox(height: 8),
              FullDetailsCard(
                title: "Location Details",
                details: {
                  "Distirict": construction.location.district,
                  "Block": construction.location.block,
                  "Village/Ward": construction.location.villageWard,
                  "Constituency": construction.location.constituency,
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
              Column(
                children: construction.uploadedDocuments.isNotEmpty
                    ? construction.uploadedDocuments.map((doc) {
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
                                    //print("Download ${doc.fileName}");
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
          Get.to(() => ConstructionForwardPage());
        },
      ),
    );
  }
}
