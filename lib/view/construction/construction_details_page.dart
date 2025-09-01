import 'package:admin_jantasewa/models/construction_model/workdemand_model.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_info_row.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
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
  late WorkDemandModel workitems;
  @override
  void initState() {
    super.initState();
    workitems = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Construction Details',
        fontsize: 16,
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'New Work Demand Details',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              SizedBox(height: 10),
              CustomInfoRow(label: "Work Name", value: workitems.workName),
              CustomInfoRow(label: "Work Details", value: workitems.workDetail),
              CustomInfoRow(
                label: "Tentative Amount",
                value: workitems.tentativeAmount,
              ),
              CustomInfoRow(label: "Remark", value: workitems.remark),
              CustomInfoRow(
                label: "Demanded Person",
                value: workitems.demandedPerson,
              ),
              CustomInfoRow(
                label: "Mobile Number",
                value: workitems.demandedPersonMobile,
              ),
              SizedBox(height: 10),
              CustomTextWidget(
                text: "Location Details",
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              SizedBox(height: 10),
              CustomInfoRow(label: "District", value: workitems.district),
              CustomInfoRow(label: 'Block', value: workitems.block),
              CustomInfoRow(label: 'Village', value: workitems.villageWard),
              CustomInfoRow(
                label: 'Consituency',
                value: workitems.constituency,
              ),
              SizedBox(height: 10),
              CustomTextWidget(
                text: 'Uploaded Documents',
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              SizedBox(height: 10),
              Column(
                children: workitems.uploadedFiles.isNotEmpty
                    ? workitems.uploadedFiles
                          .map(
                            (e) => SideCustomCard(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.file_present,
                                    color: AppColors.btnBgColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomTextWidget(
                                      text: e,
                                      fontsize: 16,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.download,
                                    color: AppColors.btnBgColor,
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList()
                    : [
                        SideCustomCard(
                          child: Row(
                            children: [
                              Icon(
                                Icons.file_present,
                                color: AppColors.btnBgColor,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomTextWidget(
                                  text: 'No document uploaded',
                                  fontsize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomForwardButton(
        onPressed: () {
          //This is the Forword Button Methods :
          CustomSnackbar.showSuccess(
            title: 'Success',
            message: "Forword Button is Pressed",
          );
        },
      ),
    );
  }
}
