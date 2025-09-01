import 'package:admin_jantasewa/models/ticket/ticket_model.dart';
import 'package:get/get.dart';

class RailTicketController extends GetxController {
  RxList<TicketModel> ticketList = <TicketModel>[].obs;
  RxList<TicketModel> filteredList = <TicketModel>[].obs;

  RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadTickets();
  }

  void loadTickets() {
    List<TicketModel> data = [
      TicketModel(
        ticketId: 'TKT001',
        trainName: 'Shatabdi Express',
        trainNumber: '12002', // <-- Add this line
        pnrNumber: '1234567890',
        journeyDate: '2025-08-10',
        from: 'Delhi',
        to: 'Bhopal',
        requestDate: '2025-08-01',
        status: 'Approved',
        userId: '9876543210',
        reason: 'Official meeting in Bhopal',
        passengerDetails: [
          PassengerDetail(name: 'Ravi Kumar', age: 30, gender: 'Male', mobile: '9876543210'),
        ],
      ),
      TicketModel(
        ticketId: 'TKT002',
        trainName: 'Rajdhani Express',
        trainNumber: '12951', // <-- Add this line
        pnrNumber: '2345678901',
        journeyDate: '2025-08-12',
        from: 'Mumbai',
        to: 'Delhi',
        requestDate: '2025-08-03',
        status: 'Pending',
        userId: '9123456780',
        reason: 'Family function in Delhi',
        passengerDetails: [
          PassengerDetail(name: 'Meena Sharma', age: 27, gender: 'Female', mobile: '9123456780'),
        ],
      ),
      TicketModel(
        ticketId: 'TKT003',
        trainName: 'Garib Rath',
        trainNumber: '12203', // <-- Add this line
        pnrNumber: '3456789012',
        journeyDate: '2025-08-15',
        from: 'Lucknow',
        to: 'Kolkata',
        requestDate: '2025-08-04',
        status: 'Rejected',
        userId: '9988776655',
        reason: 'Medical appointment',
        passengerDetails: [
          PassengerDetail(name: 'Ankit Verma', age: 35, gender: 'Male', mobile: '9988776655'),
        ],
      ),
      TicketModel(
        ticketId: 'TKT004',
        trainName: 'Duronto Express',
        trainNumber: '12274', // <-- Add this line
        pnrNumber: '4567890123',
        journeyDate: '2025-08-18',
        from: 'Patna',
        to: 'Delhi',
        requestDate: '2025-08-05',
        status: 'Approved',
        userId: '9001122334',
        reason: 'Family visit',
        passengerDetails: [
          PassengerDetail(name: 'Sunita Mishra', age: 42, gender: 'Female', mobile: '9001122334'),
          PassengerDetail(name: 'Amit Mishra', age: 45, gender: 'Male', mobile: '9005566778'),
        ],
      ),
    ];

    ticketList.assignAll(data);
    filteredList.assignAll(data);
  }

  void filterTickets(String status) {
    selectedFilter.value = status;
    if (status == 'All') {
      filteredList.assignAll(ticketList);
    } else {
      filteredList.assignAll(
        ticketList.where((ticket) => ticket.status == status),
      );
    }
  }

  statusBadgeCount(String status) {}
}
