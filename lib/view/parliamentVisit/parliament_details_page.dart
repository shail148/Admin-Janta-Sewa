import 'package:admin_jantasewa/models/parliament_visit/parliament_visit_model.dart';
import 'package:admin_jantasewa/view/parliamentVisit/parliament_forwarding_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParliamentDetailsPage extends StatefulWidget {
  const ParliamentDetailsPage({super.key});

  @override
  State<ParliamentDetailsPage> createState() => _ParliamentDetailsPageState();
}

class _ParliamentDetailsPageState extends State<ParliamentDetailsPage> {
  late ParliamentVisitModel visit;

  @override
  void initState() {
    super.initState();
    visit = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Parliament Visit Details',
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
                requestDate: visit.requestDate,
                idLabel: 'ID',
                idValue: visit.parliamentVisitId,
                userLabel: 'User ID',
                userValue: visit.userId,
                reason: visit.reason,
              ),

              SizedBox(height: 8),
              FullDetailsCard(
                title: "Parliament Visit Details",
                details: {
                  'Headed Person Name': visit.visitDetail.headedPersonName,
                  "Mobile Number": visit.visitDetail.mobileNumber,
                  "Date of Visit": visit.visitDetail.dateOfVisit,
                  "Time of Visit": visit.visitDetail.timeOfVisit,
                  "Total Number of Members": visit.visitDetail.totalMembers
                      .toString(),
                  "Parliament Name": visit.visitDetail.parliamentName,
                  "Parliament Number": visit.visitDetail.parliamentNumber,
                },
              ),
              SizedBox(height: 8),
              FullDetailsCard(
                title: "Location Details",
                details: {
                  "State": visit.locationDetail.state,
                  "District": visit.locationDetail.district,
                  "Block": visit.locationDetail.block,
                  "Constituency": visit.locationDetail.constituency,
                },
              ),
              SizedBox(height: 8),

              SizedBox(height: 16),
              CustomTextWidget(
                text: 'Upload Documents',
                fontsize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8),
              Column(
                children: visit.uploadedDocuments.isNotEmpty
                    ? visit.uploadedDocuments.map((doc) {
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
                                    // print("Download ${doc.fileName}");
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
          Get.to(() => ParliamentForwardingPage());
        },
      ),
    );
  }
}
