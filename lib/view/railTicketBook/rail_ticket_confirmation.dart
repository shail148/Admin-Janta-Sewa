import 'package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart';
import 'package:admin_jantasewa/view/railTicketBook/rail_ticket_details_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Move controller initialization outside the widget to avoid re-creating it
final RailTicketController controller = Get.put(RailTicketController(), permanent: true);

class RailTicketConfirmationPage extends StatelessWidget {
  const RailTicketConfirmationPage({super.key});
  // Remove controller initialization from here
  // final RailTicketController controller = Get.put(RailTicketController());

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Add a method to get ticket count by status
  int getStatusCount(String status) {
    if (status == "All") {
      return controller.ticketList.length;
    }
    return controller.ticketList.where((t) => t.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Janta Sewa',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
            Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 80,
              //width: double.infinity,
              child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                buildFilterButton("All"),
                SizedBox(width: 8),
                buildFilterButton("Pending"),
                SizedBox(width: 8),
                buildFilterButton("Approved"),
                SizedBox(width: 8),
                buildFilterButton("Rejected"),
              ],
              ),
            ),
            ),
         SizedBox(height: 8),
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    final ticket = controller.filteredList[index];
                  
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        
                        border: Border.all(color: AppColors.galleryBdColors),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket.ticketId,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, size: 20),
                              SizedBox(width: 8),
                              Text(ticket.passengerName),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.train, size: 20),
                              SizedBox(width: 8),
                              Text(ticket.trainName),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.compare_arrows, size: 20),
                              SizedBox(width: 8),
                              Text(ticket.route),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.date_range, size: 20),
                              SizedBox(width: 8),
                              Text('Requested Date : ${ticket.requestDate}'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Status :'),
                              SizedBox(width: 6),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(ticket.status)
                                      .withValues(alpha: 0.2),
                                  border: Border.all(
                                    color: getStatusColor(ticket.status),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CustomTextWidget(
                                  text: ticket.status,
                                  color: getStatusColor(ticket.status),
                                  fontsize: 10,
                                ),
                              ),
                              Spacer(),
                              CustomButton(
                                text: 'view',
                                textSize: 10,
                                onPressed: () {
                                  Get.to(() => RailTicketDetailsPage(),arguments: ticket);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterButton(String status) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == status;
      final count = getStatusCount(status);
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.btnBgColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
          
        ),
        child: TextButton(
          onPressed: () {
            controller.filterTickets(status);
          },
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           // spacing: 8,
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              //SizedBox(height: 8),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
