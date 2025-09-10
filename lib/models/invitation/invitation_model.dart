class InvitationDetail {
  final String typeOfInvitation;
  final String programmeName;
  final String date;
  final String time;
  final String contactPersonName;
  final String mobileNumber;
  final String remarks;
  final String location;

  InvitationDetail({
    required this.typeOfInvitation,
    required this.programmeName,
    required this.date,
    required this.time,
    required this.contactPersonName,
    required this.mobileNumber,
    required this.remarks,
    required this.location,
  });

  factory InvitationDetail.fromJson(Map<String, dynamic> json) {
    return InvitationDetail(
      typeOfInvitation: json['typeOfInvitation'] ?? '',
      programmeName: json['programmeName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      contactPersonName: json['contactPersonName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      remarks: json['remarks'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'typeOfInvitation': typeOfInvitation,
      'programmeName': programmeName,
      'date': date,
      'time': time,
      'contactPersonName': contactPersonName,
      'mobileNumber': mobileNumber,
      'remarks': remarks,
      'location': location,
    };
  }
}

class LocationDetail {
  final String district;
  final String block;
  final String villageWard;
  final String constituency;

  LocationDetail({
    required this.district,
    required this.block,
    required this.villageWard,
    required this.constituency,
  });

  factory LocationDetail.fromJson(Map<String, dynamic> json) {
    return LocationDetail(
      district: json['district'] ?? '',
      block: json['block'] ?? '',
      villageWard: json['villageWard'] ?? '',
      constituency: json['constituency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

class InvitationModel {
  final String invitationId;
  final String userId;
  final String requestDate;
  final String reason;
  final String status; // Approved | Pending | Rejected
  final InvitationDetail invitationDetail;
  final LocationDetail locationDetail;
  final List<UploadedDocument> uploadedDocuments;

  InvitationModel({
    required this.invitationId,
    required this.userId,
    required this.requestDate,
    required this.reason,
    required this.status,
    required this.invitationDetail,
    required this.locationDetail,
    required this.uploadedDocuments,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      invitationId: json['invitationId'] ?? '',
      userId: json['userId'] ?? '',
      requestDate: json['requestDate'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? 'Pending',
      invitationDetail: InvitationDetail.fromJson(
        json['invitationDetail'] ?? {},
      ),
      locationDetail: LocationDetail.fromJson(json['locationDetail'] ?? {}),
      uploadedDocuments: (json['uploadedDocuments'] as List<dynamic>? ?? [])
          .map((e) => UploadedDocument.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'userId': userId,
      'requestDate': requestDate,
      'reason': reason,
      'status': status,
      'invitationDetail': invitationDetail.toJson(),
      'locationDetail': locationDetail.toJson(),
      'uploadedDocuments': uploadedDocuments.map((e) => e.toJson()).toList(),
    };
  }
}
