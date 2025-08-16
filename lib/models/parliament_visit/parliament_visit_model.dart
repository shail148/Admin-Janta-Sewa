class ParliamentVisitModel {
  final String visitId;
  final String visitorName;
  final String constituency;
  final String mpName;
  final String visitDate;
  final String requestDate;
  final String status;

  ParliamentVisitModel({
    required this.visitId,
    required this.visitorName,
    required this.constituency,
    required this.mpName,
    required this.visitDate,
    required this.requestDate,
    required this.status,
  });

  // Factory method to create a ParliamentVisitModel from JSON
  factory ParliamentVisitModel.fromJson(Map<String, dynamic> json) {
    return ParliamentVisitModel(
      visitId: json['visitId'] ?? '',
      visitorName: json['visitorName'] ?? '',
      constituency: json['constituency'] ?? '',
      mpName: json['mpName'] ?? '',
      visitDate: json['visitDate'] ?? '',
      requestDate: json['requestDate'] ?? '',
      status: json['status'] ?? '',
    );
  }

  // Convert ParliamentVisitModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'visitId': visitId,
      'visitorName': visitorName,
      'constituency': constituency,
      'mpName': mpName,
      'visitDate': visitDate,
      'requestDate': requestDate,
      'status': status,
    };
  }

  // Add copyWith for consistency and flexibility
  ParliamentVisitModel copyWith({
    String? visitId,
    String? visitorName,
    String? constituency,
    String? mpName,
    String? visitDate,
    String? requestDate,
    String? status,
  }) {
    return ParliamentVisitModel(
      visitId: visitId ?? this.visitId,
      visitorName: visitorName ?? this.visitorName,
      constituency: constituency ?? this.constituency,
      mpName: mpName ?? this.mpName,
      visitDate: visitDate ?? this.visitDate,
      requestDate: requestDate ?? this.requestDate,
      status: status ?? this.status,
    );
  }
}


