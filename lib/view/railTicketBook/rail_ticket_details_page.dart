import 'package:admin_jantasewa/models/ticket/ticket_model.dart';
import 'package:admin_jantasewa/view/railTicketBook/rail_ticket_forwords_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RailTicketDetailsPage extends StatefulWidget {
  const RailTicketDetailsPage({super.key});

  @override
  State<RailTicketDetailsPage> createState() => _RailTicketDetailsPageState();
}

class _RailTicketDetailsPageState extends State<RailTicketDetailsPage> {
  late TicketModel ticket;
  late List<bool> passengerExpanded;

  @override
  void initState() {
    super.initState();
    ticket = Get.arguments; // load ticket from Get.arguments
    passengerExpanded = List<bool>.filled(
      ticket.passengerDetails.length,
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Train Ticket Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        text: ticket.ticketId,
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
                                  'Showing profile for user: ${ticket.userId}',
                            );
                          },
                          child: CustomTextWidget(
                            text: 'ID : ${ticket.userId}',
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
                            text: 'Message : ${ticket.reason}',
                            fontsize: 14,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Train Details
              CustomLabelText(
                text: 'Train Details',
                color: AppColors.black,
                fontsize: 16,
              ),
              const SizedBox(height: 8),
              Column(
                spacing: 5,
                children: [
                  _buildRow('PNR Number', ticket.pnrNumber),
                  _buildRow('Journey Date', ticket.journeyDate.toString()),
                  _buildRow('Train Name', ticket.trainName.toString()),
                  _buildRow('Train Number', ticket.trainNumber),
                  _buildRow('From', ticket.from),
                  _buildRow('To', ticket.to),
                  _buildRow('Request Date', ticket.requestDate),
                  _buildRow('User Mobile', ticket.userId),
                ],
              ),

              const SizedBox(height: 16),
              CustomLabelText(
                text: 'Passenger Details',
                color: AppColors.black,
                fontsize: 16,
              ),
              const SizedBox(height: 8),
              ...List.generate(ticket.passengerDetails.length, (i) {
                final passenger = ticket.passengerDetails[i];
                return Card(
                  elevation: 2,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      trailing: Icon(
                        Icons.expand_more,
                        color: AppColors.btnBgColor,
                      ),
                      leading: Icon(
                        Icons.person_outline,
                        color: AppColors.btnBgColor,
                      ),
                      title: CustomTextWidget(text: 'Passenger ${i + 1}'),
                      initiallyExpanded: passengerExpanded[i],
                      onExpansionChanged: (expanded) {
                        setState(() {
                          passengerExpanded[i] = expanded;
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildColumn('Name', passenger.name),
                                  _buildColumn('Age', passenger.age.toString()),
                                  _buildColumn('Gender', passenger.gender),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildColumn('Mobile', passenger.mobile),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),
              
            ],
          ),
        ),
        
      ),
      floatingActionButton: CustomForwardButton(
        onPressed: () {
          Get.to(() => RailTicketForwordsPage(), arguments: ticket);
        },
      ),
    );
  }

  // Reusable Row widget for train details
  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: CustomLabelText(text: label, color: AppColors.textGrey),
        ),
        Expanded(flex: 6, child: CustomTextWidget(text: value, fontsize: 14)),
      ],
    );
  }

  // Reusable Column widget for passenger details
  Widget _buildColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelText(text: '$label:', fontsize: 12),
          CustomTextWidget(text: value, fontsize: 12),
        ],
      ),
    );
  }
}
