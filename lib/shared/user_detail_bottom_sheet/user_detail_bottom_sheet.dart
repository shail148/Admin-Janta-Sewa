import 'package:admin_jantasewa/shared/user_detail_bottom_sheet/user_detail_bottomsheet_controller.dart';
//import 'package:admin_jantasewa/shared/user_detail_bottom_sheet/user_detail_bottom_sheet_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserDetailBottomSheet extends StatelessWidget {

  Color _getStatusColor(String status) {
  switch (status.trim().toLowerCase()) {
    case 'approved':
      return Colors.green;
    case 'pending':
      return Colors.amber;
    case 'in process':
      return Colors.blue;
    case 'rejected':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

  final String userId;

  const UserDetailBottomSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find<UserDetailBottomSheetController>();
    final controller = Get.put(UserDetailBottomSheetController());


    // Get user details and history data from the controller
    final userDetails = controller.userDetails;
    final userHistory = controller.userHistory;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const TabBar(
              indicatorColor: Color(0xFF403572),
              labelColor: Color(0xFF403572),
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "User Details"),
                Tab(text: "History"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // -------------------- USER DETAILS TAB --------------------
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Personal Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        _buildDetailRow("Full Name", userDetails['fullName']),
                        _buildDetailRow("Mobile Number", userDetails['mobileNumber']),
                        _buildDetailRow("WhatsApp Number", userDetails['whatsAppNumber']),
                        _buildDetailRow("Email ID", userDetails['emailId']),
                        _buildDetailRow("Date of Birth", userDetails['dob']),
                        _buildDetailRow("Blood Group/Gender", userDetails['bloodGroup']),
                        _buildDetailRow("Aadhar Number/Nationality", userDetails['aadharNumber']),
                        const SizedBox(height: 24),
                        const Text("Location Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        _buildDetailRow("Address", userDetails['address']),
                        _buildDetailRow("State", userDetails['state']),
                        _buildDetailRow("District", userDetails['district']),
                        _buildDetailRow("Block", userDetails['block']),
                        _buildDetailRow("Vidhansabha", userDetails['vidhansabha']),
                        _buildDetailRow("City/ Village", userDetails['cityVillage']),
                        _buildDetailRow("Ward Number", userDetails['wardNumber']),
                        _buildDetailRow("Pincode", userDetails['pincode']),
                      ],
                    ),
                  ),

                  // -------------------- HISTORY TAB --------------------
                  userHistory.isEmpty
                      ? const Center(child: Text("No history found."))
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: userHistory.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final ticket = userHistory[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.train,
                                          size: 20, color: Color(0xFF403572)),
                                      SizedBox(width: 6),
                                      Text("Train Ticket",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  _buildDetailRow("Ticket ID", ticket.ticketId),
                                  _buildDetailRow("Booking Date", ticket.bookingDate),


                                  Row(
                                    children: [
                                      const Text("Status: ",
                                          style: TextStyle(fontSize: 14)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(ticket.status).withOpacity(0.15), // light background
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          ticket.status,
                                          style:  TextStyle(
                                              color: _getStatusColor(ticket.status), // main text color
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatStatusTime(ticket.bookingDate),

                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(value ?? '-', style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  String _formatStatusTime(String dateString) {
    return "Today"; // Placeholder logic
  }
}


/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart';

class UserDetailBottomSheet extends StatelessWidget {
  final String userId;

  //final UserModel user;


   const UserDetailBottomSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final RailTicketController controller = Get.find<RailTicketController>();

    final userDetails = controller.ticketList.firstWhere(
      (ticket) => ticket.userId == userId,
    );

    final userHistory = controller.filteredList
        .where((ticket) => ticket.userId == userId)
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const TabBar(
              indicatorColor: Color(0xFF403572),
              labelColor: Color(0xFF403572),
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "User Details"),
                Tab(text: "History"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  /// -------------------- USER DETAILS TAB --------------------
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Personal Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        //Text('Name: ${userDetails.userId}'),

                         /* _buildDetailRow("Full Name", user.name),
                        _buildDetailRow("Mobile Number", user.phone),
                        _buildDetailRow("WhatsApp Number", user.phone),
                        _buildDetailRow("Email ID", user.email),
                        _buildDetailRow("Date of Birth", user.dob),
                        _buildDetailRow("Blood Group/Gender", user.gender),
                        _buildDetailRow("Aadhar Number/Natinality", user.nationality),  */

                         _buildDetailRow("Full Name", "Karan Sharma"),
                        _buildDetailRow("Mobile Number", "9931051525"),
                        _buildDetailRow("WhatsApp Number", "9931051525"),
                        _buildDetailRow("Email ID", "karan@gmail.com"),
                        _buildDetailRow("Date of Birth", "25-06-2001"),
                        _buildDetailRow("Blood Group/Gender", "AB+"),
                        _buildDetailRow("Aadhar Number/Nationality", "Indian"),  

                        const SizedBox(height: 24),
                        const Text("Location Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                       // Text('Address: ${userDetails.reason}'),
                         /* _buildDetailRow("State", user.state),
                        _buildDetailRow("District", user.district),
                        _buildDetailRow("Block", user.block),
                        _buildDetailRow("Vidhansabha", user.vidhansabha),
                        _buildDetailRow("City/ Village", user.cityVillage),
                        _buildDetailRow("Ward Number", user.wardNumber.toString()),
                        _buildDetailRow("Pincode", user.pincode),  */

                        _buildDetailRow("District", "A-204, Rama Apartment"),
                        _buildDetailRow("Block", "Donagargh"),
                        _buildDetailRow("Vidhansabha", "Narayanpur"),
                        _buildDetailRow("City/ Village", "Barapali"),
                        _buildDetailRow("Ward Number", "15"),
                        _buildDetailRow("Pincode", "492007"),  
                      ],
                    ),
                  ),

                  /// -------------------- HISTORY TAB --------------------
                  userHistory.isEmpty
                      ? const Center(child: Text("No history found."))
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: userHistory.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final ticket = userHistory[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.train,
                                          size: 20, color: Color(0xFF403572)),
                                      SizedBox(width: 6),
                                      Text("Train Ticket",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  _buildDetailRow("Ticket ID", ticket.ticketId),
                                  _buildDetailRow("Booking Date", ticket.requestDate),
                                  Row(
                                    children: [
                                      const Text("Status: ",
                                          style: TextStyle(fontSize: 14)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.shade100,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          ticket.status,
                                          style: const TextStyle(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatStatusTime(ticket.requestDate),
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build aligned detail rows
  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(value ?? '-', style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  /// Dummy function: use real date diff logic if needed
  String _formatStatusTime(String dateString) {
    // Replace with proper formatting like: "Today", "Yesterday", or "DD-MM-YYYY"
    return "Today"; // Placeholder
  }
}
 */

/* // lib/widgets/user_detail_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart';

class UserDetailBottomSheet extends StatelessWidget {
  final String userId; // The userId passed from the clicked row

  const UserDetailBottomSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final RailTicketController controller = Get.find<RailTicketController>();

    // Get the user details and history for the selected user
    final userDetails = controller.ticketList.firstWhere((ticket) => ticket.userId == userId);
    final userHistory = controller.filteredList.where((ticket) => ticket.userId == userId).toList();

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(), // Close the sheet when tapped outside
      child: Container(
        padding: EdgeInsets.all(16),
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Details Section
            Text('User Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Name: ${userDetails.userId}'), // Assuming userId is used for Name here
            Text('Mobile: ${userDetails.pnrNumber}'), // Replace with actual data
            Text('Email: ${userDetails.trainName}'), // Replace with actual data
            Text('Address: ${userDetails.reason}'), // Replace with actual data
            SizedBox(height: 20),

            // User History Section
            Text('History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: userHistory.length,
                itemBuilder: (context, index) {
                  final historyItem = userHistory[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Service: ${historyItem.ticketId}'),
                          Text('Status: ${historyItem.status}'),
                          Text('Date: ${historyItem.requestDate}'),
                          Text('ID: ${historyItem.ticketId}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */