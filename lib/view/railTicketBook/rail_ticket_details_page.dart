import 'package:admin_jantasewa/models/ticket/ticket_model.dart';
import 'package:admin_jantasewa/view/railTicketBook/rail_ticket_forwords_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forword_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/details_card_upper.dart';
import 'package:admin_jantasewa/widgets/full_details_card.dart';
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
        title: 'Train Ticket Confirmation',
        fontsize: 18,
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsCard(
                requestDate: ticket.requestDate,
                idLabel: 'ID',
                idValue: ticket.ticketId,
                userLabel: 'User ID',
                userValue: ticket.userId,
                reason: ticket.reason,
              ),
              const SizedBox(height: 16),

              // Train Details
              const SizedBox(height: 8),
              FullDetailsCard(
                title: "Journey Details",
                details: {
                  "PNR Number": ticket.pnrNumber,
                  "Journey Date": ticket.journeyDate.toString(),
                  "Train Name": ticket.trainName.toString(),
                  "Train Number": ticket.trainNumber,
                  "From": ticket.from,
                  "To": ticket.to,
                  "Request Date": ticket.requestDate,
                  "User Mobile": ticket.userId,
                },
              ),

              const SizedBox(height: 16),
              CustomLabelText(
                text: 'Passenger Details',
                color: AppColors.black,
                fontsize: 14,
              ),
              const SizedBox(height: 8),
              ...List.generate(ticket.passengerDetails.length, (i) {
                final passenger = ticket.passengerDetails[i];
                return Card(
                  elevation: 2,
                  color: Colors.white,
                  // margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      trailing: Icon(
                        Icons.expand_more,
                        color: AppColors.primary,
                      ),
                      leading: Icon(
                        Icons.person_outline,
                        color: AppColors.primary,
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
