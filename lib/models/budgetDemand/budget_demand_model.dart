class OfficeWorkDetail {
  final String requestFor;
  final String applicantName;
  final String mobileNumber;
  final String levelOfGovernment;
  final String departmentName;
  final String requestedOfficeWorkName;

  OfficeWorkDetail({
    required this.requestFor,
    required this.applicantName,
    required this.mobileNumber,
    required this.levelOfGovernment,
    required this.departmentName,
    required this.requestedOfficeWorkName,
  });

  factory OfficeWorkDetail.fromJson(Map<String, dynamic> json) {
    return OfficeWorkDetail(
      requestFor: json['requestFor'] ?? '',
      applicantName: json['applicantName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      levelOfGovernment: json['levelOfGovernment'] ?? '',
      departmentName: json['departmentName'] ?? '',
      requestedOfficeWorkName: json['requestedOfficeWorkName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestFor': requestFor,
      'applicantName': applicantName,
      'mobileNumber': mobileNumber,
      'levelOfGovernment': levelOfGovernment,
      'departmentName': departmentName,
      'requestedOfficeWorkName': requestedOfficeWorkName,
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

class BudgetDemandModel {
  final String budgetDemandId;
  final String userId;
  final String requestDate;
  final String reason;
  final String status;
  final OfficeWorkDetail officeWorkDetail;
  final List<UploadedDocument> uploadedDocuments;

  BudgetDemandModel({
    required this.budgetDemandId,
    required this.userId,
    required this.requestDate,
    required this.reason,
    required this.status,
    required this.officeWorkDetail,
    required this.uploadedDocuments,
  });

  factory BudgetDemandModel.fromJson(Map<String, dynamic> json) {
    return BudgetDemandModel(
      budgetDemandId: json['budgetDemandId'] ?? '',
      userId: json['userId'] ?? '',
      requestDate: json['requestDate'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? 'Pending', // <-- default fallback
      officeWorkDetail: OfficeWorkDetail.fromJson(
        json['officeWorkDetail'] ?? {},
      ),
      uploadedDocuments: (json['uploadedDocuments'] as List<dynamic>? ?? [])
          .map((e) => UploadedDocument.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'budgetDemandId': budgetDemandId,
      'userId': userId,
      'requestDate': requestDate,
      'reason': reason,
      'status': status,
      'officeWorkDetail': officeWorkDetail.toJson(),
      'uploadedDocuments': uploadedDocuments.map((e) => e.toJson()).toList(),
    };
  }
}
