import 'package:flutter/foundation.dart';

class UploadedDocument {
  final String fileName;
  final String fileSize;
  UploadedDocument({required this.fileName, required this.fileSize});
  factory UploadedDocument.fromJson(Map<String, dynamic> json) =>
      UploadedDocument(
        fileName: json['fileName'] ?? '',
        fileSize: json['fileSize'] ?? '',
      );
  Map<String, dynamic> toJson() => {'fileName': fileName, 'fileSize': fileSize};
}

@immutable
class GovernmentEmployeeComplaint {
  final String applicantName;
  final String mobileNumber;
  final String complaintType;
  final String departmentName;
  final String briefDetail;
  const GovernmentEmployeeComplaint({
    required this.applicantName,
    required this.mobileNumber,
    required this.complaintType,
    required this.departmentName,
    required this.briefDetail,
  });
  factory GovernmentEmployeeComplaint.fromJson(Map<String, dynamic> j) =>
      GovernmentEmployeeComplaint(
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        complaintType: j['complaintType'] ?? '',
        departmentName: j['departmentName'] ?? '',
        briefDetail: j['briefDetail'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'complaintType': complaintType,
    'departmentName': departmentName,
    'briefDetail': briefDetail,
  };
}

@immutable
class PoliticianComplaint {
  final String applicantName;
  final String mobileNumber;
  final String politicianName;
  final String briefDetail;
  const PoliticianComplaint({
    required this.applicantName,
    required this.mobileNumber,
    required this.politicianName,
    required this.briefDetail,
  });
  factory PoliticianComplaint.fromJson(Map<String, dynamic> j) =>
      PoliticianComplaint(
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        politicianName: j['politicianName'] ?? '',
        briefDetail: j['briefDetail'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'politicianName': politicianName,
    'briefDetail': briefDetail,
  };
}

@immutable
class NationalStateWorkComplaint {
  final String applicantName;
  final String mobileNumber;
  final String departmentName;
  final String briefDetail;
  const NationalStateWorkComplaint({
    required this.applicantName,
    required this.mobileNumber,
    required this.departmentName,
    required this.briefDetail,
  });
  factory NationalStateWorkComplaint.fromJson(Map<String, dynamic> j) =>
      NationalStateWorkComplaint(
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        departmentName: j['departmentName'] ?? '',
        briefDetail: j['briefDetail'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'departmentName': departmentName,
    'briefDetail': briefDetail,
  };
}

@immutable
class MpOfficeComplaint {
  final String applicantName;
  final String mobileNumber;
  final String officeType;
  final String briefDetail;
  const MpOfficeComplaint({
    required this.applicantName,
    required this.mobileNumber,
    required this.officeType,
    required this.briefDetail,
  });
  factory MpOfficeComplaint.fromJson(Map<String, dynamic> j) =>
      MpOfficeComplaint(
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        officeType: j['officeType'] ?? '',
        briefDetail: j['briefDetail'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'officeType': officeType,
    'briefDetail': briefDetail,
  };
}

@immutable
class ComplaintLetterModel {
  final String date;
  final String complaintId;
  final String userId;
  final String title;
  final String message;
  final String status;
  final GovernmentEmployeeComplaint? governmentEmployee;
  final PoliticianComplaint? politician;
  final NationalStateWorkComplaint? nationalStateWork;
  final MpOfficeComplaint? mpOffice;
  final List<UploadedDocument> uploadedDocuments;

  const ComplaintLetterModel({
    required this.date,
    required this.complaintId,
    required this.userId,
    required this.title,
    required this.message,
    required this.status,
    this.governmentEmployee,
    this.politician,
    this.nationalStateWork,
    this.mpOffice,
    this.uploadedDocuments = const [],
  });

  factory ComplaintLetterModel.fromJson(Map<String, dynamic> j) =>
      ComplaintLetterModel(
        date: j['date'] ?? '',
        complaintId: j['complaintId'] ?? '',
        userId: j['userId'] ?? '',
        title: j['title'] ?? 'Complaint Letter',
        message: j['message'] ?? '',
        status: j['status'] ?? 'Pending',
        governmentEmployee: j['governmentEmployee'] != null
            ? GovernmentEmployeeComplaint.fromJson(j['governmentEmployee'])
            : null,
        politician: j['politician'] != null
            ? PoliticianComplaint.fromJson(j['politician'])
            : null,
        nationalStateWork: j['nationalStateWork'] != null
            ? NationalStateWorkComplaint.fromJson(j['nationalStateWork'])
            : null,
        mpOffice: j['mpOffice'] != null
            ? MpOfficeComplaint.fromJson(j['mpOffice'])
            : null,
        uploadedDocuments: (j['uploadedDocuments'] as List<dynamic>? ?? [])
            .map((doc) => UploadedDocument.fromJson(doc))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'complaintId': complaintId,
    'userId': userId,
    'title': title,
    'message': message,
    'status': status,
    'governmentEmployee': governmentEmployee?.toJson(),
    'politician': politician?.toJson(),
    'nationalStateWork': nationalStateWork?.toJson(),
    'mpOffice': mpOffice?.toJson(),
    'uploadedDocuments': uploadedDocuments.map((doc) => doc.toJson()).toList(),
  };
}
