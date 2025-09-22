 class UserDetailBottomSheetModel {
  final String ticketId;
  final String bookingDate;
  final String status;

  UserDetailBottomSheetModel({
    required this.ticketId,
    required this.bookingDate,
    required this.status,
  });

  factory UserDetailBottomSheetModel.fromJson(Map<String, dynamic> json) {
    return UserDetailBottomSheetModel(
      ticketId: json['ticketId'] ?? '',
      bookingDate: json['bookingDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
} 


/* class TicketModel {
  final String ticketId;
  final String bookingDate;
  final String status;

  TicketModel({
    required this.ticketId,
    required this.bookingDate,
    required this.status,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'] ?? '',
      bookingDate: json['bookingDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
 */