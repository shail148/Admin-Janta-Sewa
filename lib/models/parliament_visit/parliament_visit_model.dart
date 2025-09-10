class ParliamentVisitDetail {
  final String headedPersonName;
  final String mobileNumber;
  final String dateOfVisit;
  final String timeOfVisit;
  final int totalMembers;
  final String parliamentName;
  final String parliamentNumber;

  ParliamentVisitDetail({
    required this.headedPersonName,
    required this.mobileNumber,
    required this.dateOfVisit,
    required this.timeOfVisit,
    required this.totalMembers,
    required this.parliamentName,
    required this.parliamentNumber,
  });

  factory ParliamentVisitDetail.fromJson(Map<String, dynamic> json) {
    return ParliamentVisitDetail(
      headedPersonName: json['headedPersonName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      dateOfVisit: json['dateOfVisit'] ?? '',
      timeOfVisit: json['timeOfVisit'] ?? '',
      totalMembers: json['totalMembers'] ?? 0,
      parliamentName: json['parliamentName'] ?? '',
      parliamentNumber: json['parliamentNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headedPersonName': headedPersonName,
      'mobileNumber': mobileNumber,
      'dateOfVisit': dateOfVisit,
      'timeOfVisit': timeOfVisit,
      'totalMembers': totalMembers,
      'parliamentName': parliamentName,
      'parliamentNumber': parliamentNumber,
    };
  }
}

class LocationDetail {
  final String state;
  final String district;
  final String block;
  final String villageWard;
  final String constituency;

  LocationDetail({
    required this.state,
    required this.district,
    required this.block,
    required this.villageWard,
    required this.constituency,
  });

  factory LocationDetail.fromJson(Map<String, dynamic> json) {
    return LocationDetail(
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      block: json['block'] ?? '',
      villageWard: json['villageWard'] ?? '',
      constituency: json['constituency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'district': district,
      'block': block,
      'villageWard': villageWard,
      'constituency': constituency,
    };
  }
}

class UploadedDocument {
  final String fileName;
  final String fileSize;

  UploadedDocument({required this.fileName, required this.fileSize});

  factory UploadedDocument.fromJson(Map<String, dynamic> json) {
    return UploadedDocument(
      fileName: json['fileName'] ?? '',
      fileSize: json['fileSize'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'fileSize': fileSize};
  }
}

class ParliamentVisitModel {
  final String parliamentVisitId; // ✅ updated field
  final String userId;
  final String requestDate;
  final String reason;
  final String status; // Approved | Pending | Rejected
  final ParliamentVisitDetail visitDetail;
  final LocationDetail locationDetail;
  final List<UploadedDocument> uploadedDocuments;

  ParliamentVisitModel({
    required this.parliamentVisitId,
    required this.userId,
    required this.requestDate,
    required this.reason,
    required this.status,
    required this.visitDetail,
    required this.locationDetail,
    required this.uploadedDocuments,
  });

  factory ParliamentVisitModel.fromJson(Map<String, dynamic> json) {
    return ParliamentVisitModel(
      parliamentVisitId: json['parliamentVisitId'] ?? '',
      userId: json['userId'] ?? '',
      requestDate: json['requestDate'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? 'Pending',
      visitDetail: ParliamentVisitDetail.fromJson(json['visitDetail'] ?? {}),
      locationDetail: LocationDetail.fromJson(json['locationDetail'] ?? {}),
      uploadedDocuments: (json['uploadedDocuments'] as List<dynamic>? ?? [])
          .map((e) => UploadedDocument.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parliamentVisitId': parliamentVisitId,
      'userId': userId,
      'requestDate': requestDate,
      'reason': reason,
      'status': status,
      'visitDetail': visitDetail.toJson(),
      'locationDetail': locationDetail.toJson(),
      'uploadedDocuments': uploadedDocuments.map((e) => e.toJson()).toList(),
    };
  }
}
