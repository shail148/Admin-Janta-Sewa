class PassengerDetail {
  final String name;
  final int age;
  final String gender;
  final String mobile;

  PassengerDetail({
    required this.name,
    required this.age,
    required this.gender,
    required this.mobile,
  });

  factory PassengerDetail.fromJson(Map<String, dynamic> json) {
    return PassengerDetail(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'mobile': mobile,
    };
  }
}

class TicketModel {
  final String ticketId;
  final String trainName;
  final String trainNumber; // <-- Add this line
  final String pnrNumber;
  final String journeyDate;
  final String from;
  final String to;
  final String requestDate;
  final String status;
  final String userId;
  final String reason;
  final List<PassengerDetail> passengerDetails;

  TicketModel({
    required this.ticketId,
    required this.trainName,
    required this.trainNumber, // <-- Add this line
    required this.pnrNumber,
    required this.journeyDate,
    required this.from,
    required this.to,
    required this.requestDate,
    required this.status,
    required this.userId,
    required this.reason,
    required this.passengerDetails,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json['ticketId'] ?? '',
      trainName: json['trainName'] ?? '',
      trainNumber: json['trainNumber'] ?? '', // <-- Add this line
      pnrNumber: json['pnrNumber'] ?? '',
      journeyDate: json['journeyDate'] ?? '',
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      requestDate: json['requestDate'] ?? '',
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
      reason: json['reason'] ?? '',
      passengerDetails: (json['passengerDetails'] as List<dynamic>? ?? [])
          .map((e) => PassengerDetail.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'trainName': trainName,
      'trainNumber': trainNumber, // <-- Add this line
      'pnrNumber': pnrNumber,
      'journeyDate': journeyDate,
      'from': from,
      'to': to,
      'requestDate': requestDate,
      'status': status,
      'userId': userId,
      'reason': reason,
      'passengerDetails': passengerDetails.map((e) => e.toJson()).toList(),
    };
  }
}
