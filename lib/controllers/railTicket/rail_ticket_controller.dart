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
        passengerName: 'Ravi Kumar',
        trainName: 'Shatabdi Express',
        route: 'Delhi - Bhopal',
        requestDate: '2025-08-01',
        status: 'Approved',
      ),
      TicketModel(
        ticketId: 'TKT002',
        passengerName: 'Meena Sharma',
        trainName: 'Rajdhani Express',
        route: 'Mumbai - Delhi',
        requestDate: '2025-08-03',
        status: 'Pending',
      ),
      TicketModel(
        ticketId: 'TKT003',
        passengerName: 'Ankit Verma',
        trainName: 'Garib Rath',
        route: 'Lucknow - Kolkata',
        requestDate: '2025-08-04',
        status: 'Rejected',
      ),
      TicketModel(
  ticketId: 'TKT004',
  passengerName: 'Sunita Mishra',
  trainName: 'Duronto Express',
  route: 'Patna - Delhi',
  requestDate: '2025-08-05',
  status: 'Approved',
),
TicketModel(
  ticketId: 'TKT005',
  passengerName: 'Amit Yadav',
  trainName: 'Tejas Express',
  route: 'Lucknow - New Delhi',
  requestDate: '2025-08-06',
  status: 'Pending',
),
TicketModel(
  ticketId: 'TKT006',
  passengerName: 'Neha Agarwal',
  trainName: 'Vande Bharat',
  route: 'Varanasi - Delhi',
  requestDate: '2025-08-07',
  status: 'Rejected',
),
TicketModel(
  ticketId: 'TKT007',
  passengerName: 'Rohan Mehta',
  trainName: 'Howrah Express',
  route: 'Kolkata - Mumbai',
  requestDate: '2025-08-08',
  status: 'Approved',
),
TicketModel(
  ticketId: 'TKT008',
  passengerName: 'Priya Singh',
  trainName: 'Intercity Express',
  route: 'Kanpur - Lucknow',
  requestDate: '2025-08-08',
  status: 'Pending',
),
TicketModel(
  ticketId: 'TKT009',
  passengerName: 'Mohit Saini',
  trainName: 'Goa Express',
  route: 'Delhi - Goa',
  requestDate: '2025-08-09',
  status: 'Rejected',
),
TicketModel(
  ticketId: 'TKT010',
  passengerName: 'Divya Thakur',
  trainName: 'Deccan Queen',
  route: 'Pune - Mumbai',
  requestDate: '2025-08-09',
  status: 'Approved',
),
TicketModel(
  ticketId: 'TKT011',
  passengerName: 'Vikram Chauhan',
  trainName: 'Janshatabdi Express',
  route: 'Agra - Delhi',
  requestDate: '2025-08-10',
  status: 'Pending',
),
TicketModel(
  ticketId: 'TKT012',
  passengerName: 'Pooja Bhatt',
  trainName: 'Palace on Wheels',
  route: 'Jaipur - Jodhpur',
  requestDate: '2025-08-11',
  status: 'Approved',
),
TicketModel(
  ticketId: 'TKT013',
  passengerName: 'Suresh Gupta',
  trainName: 'Kalka Mail',
  route: 'Howrah - Kalka',
  requestDate: '2025-08-11',
  status: 'Rejected',
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
}
