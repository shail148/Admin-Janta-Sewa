class HospitalAdmissionModel {
  final String requestId;
  final String userId;
  final String patientName;
  final int patientAge;
  final String patientGender;
  final String admissionType; // Emergency, Planned
  final String diseaseName;
  final String requestDate;
  final String status; // Pending, Approved, Rejected
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalContactPerson;
  final String hospitalContactMobile;
  final String hospitalContactWhatsApp;
  final String reason; // Description of request
  final String uploadedDocument; // file path / URL
  final String sourceName;
  final String sourceDesignation;
  final String sourceContactNumber;
  final String relationWithPatient;
  final String attendentName;

  HospitalAdmissionModel({
    required this.requestId,
    required this.userId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.admissionType,
    required this.diseaseName,
    required this.requestDate,
    required this.status,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.hospitalContactPerson,
    required this.hospitalContactMobile,
    required this.hospitalContactWhatsApp,
    required this.reason,
    required this.uploadedDocument,
    required this.sourceName,
    required this.sourceDesignation,
    required this.sourceContactNumber,
    required this.relationWithPatient,
    required this.attendentName,
  });

  factory HospitalAdmissionModel.fromJson(Map<String, dynamic> json) {
    return HospitalAdmissionModel(
      requestId: json['requestId'] ?? '',
      userId: json['userId'] ?? '',
      patientName: json['patientName'] ?? '',
      patientAge: json['patientAge'] ?? 0,
      patientGender: json['patientGender'] ?? '',
      admissionType: json['admissionType'] ?? '',
      diseaseName: json['diseaseName'] ?? '',
      requestDate: json['requestDate'] ?? '',
      status: json['status'] ?? 'Pending',
      hospitalName: json['hospitalName'] ?? '',
      hospitalAddress: json['hospitalAddress'] ?? '',
      hospitalContactPerson: json['hospitalContactPerson'] ?? '',
      hospitalContactMobile: json['hospitalContactMobile'] ?? '',
      hospitalContactWhatsApp: json['hospitalContactWhatsApp'] ?? '',
      reason: json['reason'] ?? '',
      uploadedDocument: json['uploadedDocument'] ?? '',
      sourceName: json['sourceName'] ?? '',
      sourceDesignation: json['sourceDesignation'] ?? '',
      sourceContactNumber: json['sourceContactNumber'] ?? '',
      relationWithPatient: json['relationWithPatient'] ?? '',
      attendentName: json['attendentName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'userId': userId,
      'patientName': patientName,
      'patientAge': patientAge,
      'patientGender': patientGender,
      'admissionType': admissionType,
      'diseaseName': diseaseName,
      'requestDate': requestDate,
      'status': status,
      'hospitalName': hospitalName,
      'hospitalAddress': hospitalAddress,
      'hospitalContactPerson': hospitalContactPerson,
      'hospitalContactMobile': hospitalContactMobile,
      'hospitalContactWhatsApp': hospitalContactWhatsApp,
      'reason': reason,
      'uploadedDocument': uploadedDocument,
      'sourceName': sourceName,
      'sourceDesignation': sourceDesignation,
      'sourceContactNumber': sourceContactNumber,
      'relationWithPatient': relationWithPatient,
      'attendentName': attendentName,
    };
  }
}
