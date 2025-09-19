import "package:admin_jantasewa/models/invitation/invitation_model.dart";
import "package:admin_jantasewa/view/invitation/invitation_forwarding_page.dart";
import "package:admin_jantasewa/constants/colors.dart";
import "package:admin_jantasewa/widgets/custom_app_bar.dart";
import "package:admin_jantasewa/widgets/custom_forword_button.dart";
import "package:admin_jantasewa/widgets/custom_text.dart";
import "package:admin_jantasewa/widgets/details_card_upper.dart";
import "package:admin_jantasewa/widgets/full_details_card.dart";
import "package:admin_jantasewa/widgets/side_card_design.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class InvitationDetailsPage extends StatefulWidget {
  const InvitationDetailsPage({super.key});

  @override
  State<InvitationDetailsPage> createState() => _InvitationDetailsPageState();
}

class _InvitationDetailsPageState extends State<InvitationDetailsPage> {
  //fetch data from controller
  late InvitationModel invitation;

  @override
  void initState() {
    super.initState();
    invitation = Get.arguments; // load ticket from Get.arguments
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: ' Invitation Details',
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
                requestDate: invitation.requestDate,
                idLabel: 'ID',
                idValue: invitation.invitationId,
                userLabel: 'User ID',
                userValue: invitation.userId,
                reason: invitation.reason,
              ),

              SizedBox(height: 8),
              FullDetailsCard(
                title: "Invitation Details",
                details: {
                  "Event Name": invitation.invitationDetail.typeOfInvitation,
                  'Program Name': invitation.invitationDetail.programmeName,
                  "Date": invitation.invitationDetail.date,
                  "Venue": invitation.invitationDetail.location,
                  "Time": invitation.invitationDetail.time,

                  "Contact Person Name":
                      invitation.invitationDetail.contactPersonName,
                  "Mobile Number": invitation.invitationDetail.mobileNumber,
                  'Remarks': invitation.invitationDetail.remarks.toString(),
                },
              ),
              SizedBox(height: 8),
              FullDetailsCard(
                title: "location Details",
                details: {
                  "District": invitation.locationDetail.district,
                  'Block': invitation.locationDetail.block.toString(),
                  "Village": invitation.locationDetail.villageWard,
                  "Consituency": invitation.locationDetail.constituency
                      .toString(),
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
                children: invitation.uploadedDocuments.isNotEmpty
                    ? invitation.uploadedDocuments.map((doc) {
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
          Get.to(() => InvitationForwardingPage());
        },
      ),
    );
  }
}
