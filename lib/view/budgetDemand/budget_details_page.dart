import 'package:admin_jantasewa/models/budgetDemand/budget_demand_model.dart';
import 'package:admin_jantasewa/view/budgetDemand/budget_forword_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetDetailsPage extends StatefulWidget {
  const BudgetDetailsPage({super.key});

  @override
  State<BudgetDetailsPage> createState() => _BudgetDetailsPageState();
}

class _BudgetDetailsPageState extends State<BudgetDetailsPage> {
  late BudgetDemandModel budgetDemand;

  @override
  void initState() {
    super.initState();
    budgetDemand = Get.arguments; // load ticket from Get.arguments
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
                requestDate: budgetDemand.requestDate,
                idLabel: 'ID',
                idValue: budgetDemand.budgetDemandId,
                userLabel: 'User ID',
                userValue: budgetDemand.userId,
                reason: budgetDemand.reason,
              ),

              SizedBox(height: 8),
              FullDetailsCard(
                title: "New Government Office Details",
                details: {
                  "Request For": budgetDemand.officeWorkDetail.requestFor,
                  "Applicant Name": budgetDemand.officeWorkDetail.applicantName,
                  "Mobile Number": budgetDemand.officeWorkDetail.mobileNumber,
                  "Level of Government":
                      budgetDemand.officeWorkDetail.levelOfGovernment,
                  "Department Name":
                      budgetDemand.officeWorkDetail.departmentName,
                  "Requested Office Work Name":
                      budgetDemand.officeWorkDetail.requestedOfficeWorkName,
                },
              ),

              SizedBox(height: 8),
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
                        text: budgetDemand.uploadedDocuments.isNotEmpty
                            ? budgetDemand.uploadedDocuments.join(', ')
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
          Get.to(() => BudgetForwordPage());
        },
      ),
    );
  }
}
