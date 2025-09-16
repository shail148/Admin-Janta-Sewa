import 'package:admin_jantasewa/models/recommendation/recommendation_model.dart';
import 'package:admin_jantasewa/view/recommendation/recommendation_forwarding_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendationDetailsPage extends StatefulWidget {
  const RecommendationDetailsPage({super.key});

  @override
  State<RecommendationDetailsPage> createState() =>
      _RecommendationDetailsPageState();
}

class _RecommendationDetailsPageState extends State<RecommendationDetailsPage> {
  late RecommendationModel recommendation;

  @override
  void initState() {
    super.initState();
    recommendation = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Recommendation Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top info card
              DetailsCard(
                requestDate: recommendation.date,
                idLabel: 'Recommendation ID',
                idValue: recommendation.recommendationId,
                userLabel: 'User ID',
                userValue: recommendation.userId,
                reason: recommendation.message,
              ),
              SizedBox(height: 8),
              // Details card for each type
              if (recommendation.culturalProgramme != null)
                FullDetailsCard(
                  title: 'Cultural Programme Details',
                  details: {
                    'Applicant Name':
                        recommendation.culturalProgramme!.applicantName,
                    'Mobile Number':
                        recommendation.culturalProgramme!.mobileNumber,
                    'Host Detail': recommendation.culturalProgramme!.hostDetail,
                    'Date': recommendation.culturalProgramme!.date,
                    'Cultural Programme Name':
                        recommendation.culturalProgramme!.culturalProgrammeName,
                    'In Letter Of':
                        recommendation.culturalProgramme!.inLetterOf,
                    'Address': recommendation.culturalProgramme!.address,
                  },
                ),
              if (recommendation.transfer != null)
                FullDetailsCard(
                  title: 'Transfer Letter Details',
                  details: {
                    'Type of Transfer': recommendation.transfer!.typeOfTransfer,
                    'Applicant Name': recommendation.transfer!.applicantName,
                    'Mobile Number': recommendation.transfer!.mobileNumber,
                    'Designation': recommendation.transfer!.designation,
                    'Department': recommendation.transfer!.department,
                    'Post Office': recommendation.transfer!.postOffice,
                    'Opted Office': recommendation.transfer!.optedOffice,
                    'Reason for Transfer':
                        recommendation.transfer!.reasonForTransfer,
                    'Address': recommendation.transfer!.address,
                  },
                ),
              if (recommendation.posting != null)
                FullDetailsCard(
                  title: 'Posting Letter Details',
                  details: {
                    'Type of Posting': recommendation.posting!.typeOfPosting,
                    'Applicant Name': recommendation.posting!.applicantName,
                    'Mobile Number': recommendation.posting!.mobileNumber,
                    'Designation': recommendation.posting!.designation,
                    'Department': recommendation.posting!.department,
                    'Post Office': recommendation.posting!.postOffice,
                    'Opted Office': recommendation.posting!.optedOffice,
                    'Reason for Posting':
                        recommendation.posting!.reasonForPosting,
                    'Address': recommendation.posting!.address,
                  },
                ),
              if (recommendation.quarterAllotment != null)
                FullDetailsCard(
                  title: 'Quarter Allotment Details',
                  details: {
                    'Type of Allotment':
                        recommendation.quarterAllotment!.typeOfAllotment,
                    'Full Name': recommendation.quarterAllotment!.fullName,
                    'Mobile Number':
                        recommendation.quarterAllotment!.mobileNumber,
                    'Department': recommendation.quarterAllotment!.department,
                    'Opted Office':
                        recommendation.quarterAllotment!.optedOffice,
                    'Reason for Allotment':
                        recommendation.quarterAllotment!.reasonForAllotment,
                    'Address': recommendation.quarterAllotment!.address,
                  },
                ),
              if (recommendation.award != null)
                FullDetailsCard(
                  title: 'Award Details',
                  details: {
                    'Type of Award': recommendation.award!.typeOfAward,
                    'Applicant Name': recommendation.award!.applicantName,
                    'Mobile Number': recommendation.award!.mobileNumber,
                    'Career Achievement':
                        recommendation.award!.careerAchievement,
                    'Award Name': recommendation.award!.awardName,
                    'Brief Detail': recommendation.award!.briefDetail,
                    'Address': recommendation.award!.address,
                  },
                ),
              if (recommendation.admission != null)
                FullDetailsCard(
                  title: 'Admission Details',
                  details: {
                    'Type of Admission':
                        recommendation.admission!.typeOfAdmission,
                    'Applicant Name': recommendation.admission!.applicantName,
                    'Mobile Number': recommendation.admission!.mobileNumber,
                    'Student Name': recommendation.admission!.studentName,
                    'Class/Course': recommendation.admission!.classCourse,
                    'Address': recommendation.admission!.address,
                  },
                ),
              if (recommendation.landAllotment != null)
                FullDetailsCard(
                  title: 'Land Allotment Details',
                  details: {
                    'Applicant Name':
                        recommendation.landAllotment!.applicantName,
                    'Mobile Number': recommendation.landAllotment!.mobileNumber,
                    'Opted Department':
                        recommendation.landAllotment!.optedDepartment,
                    'Opted Land Office':
                        recommendation.landAllotment!.optedLandOffice,
                    'Reason for Land Allotment':
                        recommendation.landAllotment!.reasonForLandAllotment,
                    'Address': recommendation.landAllotment!.address,
                  },
                ),
              if (recommendation.jobRecommendation != null)
                FullDetailsCard(
                  title: 'Job Recommendation Details',
                  details: {
                    'Job Type':
                        recommendation.jobRecommendation!.jobRecommendationType,
                    'Applicant Name':
                        recommendation.jobRecommendation!.applicantName,
                    'Mobile Number':
                        recommendation.jobRecommendation!.mobileNumber,
                    'Post Name': recommendation.jobRecommendation!.postName,
                    'Department': recommendation.jobRecommendation!.department,
                    'Address': recommendation.jobRecommendation!.address,
                  },
                ),
              if (recommendation.financialRecommendation != null)
                FullDetailsCard(
                  title: 'Financial Recommendation Details',
                  details: {
                    'Department':
                        recommendation.financialRecommendation!.department,
                    'Applicant Name':
                        recommendation.financialRecommendation!.applicantName,
                    'Mobile Number':
                        recommendation.financialRecommendation!.mobileNumber,
                    'Reason of Problem':
                        recommendation.financialRecommendation!.reasonOfProblem,
                    'Tentative Amount':
                        recommendation.financialRecommendation!.tentativeAmount,
                    'Address': recommendation.financialRecommendation!.address,
                  },
                ),
              if (recommendation.otherRecommendation != null)
                FullDetailsCard(
                  title: 'Other Recommendation Details',
                  details: {
                    'Applicant Name':
                        recommendation.otherRecommendation!.applicantName,
                    'Mobile Number':
                        recommendation.otherRecommendation!.mobileNumber,
                    'Recommendation Need':
                        recommendation.otherRecommendation!.recommendationNeed,
                    'Address': recommendation.otherRecommendation!.address,
                  },
                ),
              SizedBox(height: 8),
              // Uploaded documents
              Text(
                'Uploaded Documents',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              if (recommendation.uploadedDocuments.isEmpty)
                SideCustomCard(
                  child: CustomTextWidget(
                    text: 'No document uploaded',
                    fontsize: 14,
                    color: AppColors.black,
                  ),
                )
              else
                ...recommendation.uploadedDocuments.map((doc) {
                  bool isPdf = doc.fileName.toLowerCase().endsWith('.pdf');
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: SideCustomCard(
                      child: Row(
                        children: [
                          Icon(
                            isPdf
                                ? Icons.picture_as_pdf
                                : Icons.insert_drive_file,
                            color: isPdf ? Colors.red : AppColors.btnBgColor,
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
                }),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomForwardButton(
        onPressed: () {
          Get.to(() => RecommendationForwardingPage());
        },
      ),
    );
  }
}
