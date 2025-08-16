class TicketModel {
  final String ticketId;
  final String passengerName;
  final String trainName;
  final String route;
  final String requestDate;
  final String status;

  TicketModel({
    required this.ticketId,
    required this.passengerName,
    required this.trainName,
    required this.route,
    required this.requestDate,
    required this.status,
  });

  // Factory method to create a TicketModel from JSON
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'] ?? '',
      passengerName: json['passengerName'] ?? '',
      trainName: json['trainName'] ?? '',
      route: json['route'] ?? '',
      requestDate: json['requestDate'] ?? '',
      status: json['status'] ?? '',
    );
  }

  // Convert TicketModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'passengerName': passengerName,
      'trainName': trainName,
      'route': route,
      'requestDate': requestDate,
      'status': status,
    };
  }
}
