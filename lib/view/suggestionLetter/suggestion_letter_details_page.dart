import 'package:admin_jantasewa/models/suggestionLetter/suggestion_letter_model.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestionLetterDetailsPage extends StatefulWidget {
  const SuggestionLetterDetailsPage({super.key});

  @override
  State<SuggestionLetterDetailsPage> createState() =>
      _SuggestionLetterDetailsPageState();
}

class _SuggestionLetterDetailsPageState
    extends State<SuggestionLetterDetailsPage> {
  late SuggestionLetterModel suggestion;

  @override
  void initState() {
    super.initState();
    suggestion = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Suggestion Letter Details',
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
                requestDate: suggestion.date,
                idLabel: 'Letter ID',
                idValue: suggestion.letterId,
                userLabel: 'User ID',
                userValue: suggestion.userId,
                reason: suggestion.message,
              ),
              SizedBox(height: 8),
              if (suggestion.benefit != null) ...[
                FullDetailsCard(
                  title: "Benefit Suggestion Details",
                  details: {
                    "Benefit Name": suggestion.benefit!.benefitName,
                    "Description": suggestion.benefit!.description,
                    "Remark": suggestion.benefit!.remark,
                  },
                ),
              ] else if (suggestion.scheme != null) ...[
                FullDetailsCard(
                  title: "Scheme Suggestion Details",
                  details: {
                    "Scheme Name": suggestion.scheme!.schemeName,
                    "Eligibility": suggestion.scheme!.eligibility,
                    "Remark": suggestion.scheme!.remark,
                  },
                ),
              ] else if (suggestion.govDepartment != null) ...[
                FullDetailsCard(
                  title: "Gov Department Suggestion Details",
                  details: {
                    "Department Name": suggestion.govDepartment!.departmentName,
                    "Issue": suggestion.govDepartment!.issue,
                    "Remark": suggestion.govDepartment!.remark,
                  },
                ),
              ],
              SizedBox(height: 8),
              FullDetailsCard(
                title: "Location Details",
                details: {
                  "District": suggestion.location.district,
                  "Block": suggestion.location.block,
                  "Village": suggestion.location.villageWard,
                  "Constituency": suggestion.location.constituency,
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
                children: suggestion.uploadedDocuments.isNotEmpty
                    ? suggestion.uploadedDocuments.map((doc) {
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
          Get.toNamed('/suggestionLetterForwarding', arguments: suggestion);
        },
      ),
    );
  }
}
