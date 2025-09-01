import 'package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart';
import 'package:admin_jantasewa/view/railTicketBook/rail_ticket_details_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:admin_jantasewa/widgets/view_details_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Move controller initialization outside the widget to avoid re-creating it
final RailTicketController controller = Get.put(
  RailTicketController(),
  permanent: true,
);

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
          SizedBox(height: 12),
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    final ticket = controller.filteredList[index];

                    return SideCustomCard(
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.btnBgColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CustomTextWidget(text: ticket.ticketId, fontsize: 12, color: AppColors.btnBgColor), 
                          ),

                          Row(
                            children: [
                              Icon(Icons.perm_identity_outlined, size: 20),
                                SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                 //Profile Showing Logic
                                 CustomSnackbar.showSuccess(title: 'Profile', message: 'Showing profile for user: ${ticket.userId}');
                                },
                                child: CustomTextWidget(text: 'ID : ${ticket.userId}', fontsize: 12,color: AppColors.btnBgColor,)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.date_range, size: 20),
                              SizedBox(width: 8),
                              CustomTextWidget(text: 'Requested Date : ${ticket.requestDate}',fontsize: 12,)
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.chat, size: 20),
                              SizedBox(width: 8),
                              CustomTextWidget(text: 'Message : ${ticket.reason}', fontsize: 12,),
                            ],
                          ),
                          Row(
                            children: [
                               Icon(Icons.access_time, size: 20),
                                SizedBox(width: 8),
                              CustomTextWidget(text: 'Status :', fontsize: 12,),
                              SizedBox(width: 6),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(
                                    ticket.status,
                                  ).withValues(alpha: 0.2),
                                  // border: Border.all(
                                  //   color: getStatusColor(ticket.status),
                                  // ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CustomTextWidget(
                                  text: ticket.status,
                                  color: getStatusColor(ticket.status),
                                  fontsize: 10,
                                   fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                             ViewDetailsButton(onTap: (){
                              Get.to(()=>RailTicketDetailsPage(),arguments: ticket);
                             })
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
          color: isSelected ? AppColors.btnBgColor : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? Colors.white : AppColors.btnBgColor,
          ),
        ),
        child: TextButton(
          onPressed: () {
            controller.filterTickets(status);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppColors.textColor,
                ),
              ),
              //SizedBox(height: 8),
              Text(
                status,
                style: TextStyle(
                  fontSize: 11,
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
