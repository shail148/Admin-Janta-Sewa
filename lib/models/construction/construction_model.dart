import 'package:flutter/foundation.dart';

enum WorkStage { newDemand, pendingCompletion, beneficiaryOriented }

WorkStage workStageFrom(String s) {
  switch (s) {
    case 'newDemand':
      return WorkStage.newDemand;
    case 'pendingCompletion':
      return WorkStage.pendingCompletion;
    case 'beneficiaryOriented':
      return WorkStage.beneficiaryOriented;
    default:
      return WorkStage.newDemand;
  }
}

String workStageTo(WorkStage s) {
  switch (s) {
    case WorkStage.newDemand:
      return 'newDemand';
    case WorkStage.pendingCompletion:
      return 'pendingCompletion';
    case WorkStage.beneficiaryOriented:
      return 'beneficiaryOriented';
  }
}

/// Common contact pair used in sections
@immutable
class ContactPair {
  final String demandedPerson;
  final String mobileNumber;
  const ContactPair({required this.demandedPerson, required this.mobileNumber});

  factory ContactPair.fromJson(Map<String, dynamic> j) => ContactPair(
    demandedPerson: j['demandedPerson'] ?? '',
    mobileNumber: j['mobileNumber'] ?? '',
  );
  Map<String, dynamic> toJson() => {
    'demandedPerson': demandedPerson,
    'mobileNumber': mobileNumber,
  };
}

/// 1) New Work Demand Details
@immutable
class NewWorkDemand {
  final String workBy; // e.g., Suresh
  final String workDetail; // e.g., Road Repair
  final String tentativeAmount; // string to keep formatting like ₹1,00,000
  final String remark;
  final ContactPair contact;
  const NewWorkDemand({
    required this.workBy,
    required this.workDetail,
    required this.tentativeAmount,
    required this.remark,
    required this.contact,
  });

  factory NewWorkDemand.fromJson(Map<String, dynamic> j) => NewWorkDemand(
    workBy: j['workBy'] ?? '',
    workDetail: j['workDetail'] ?? '',
    tentativeAmount: j['tentativeAmount'] ?? '',
    remark: j['remark'] ?? '',
    contact: ContactPair.fromJson(j['contact'] ?? const {}),
  );
  Map<String, dynamic> toJson() => {
    'workBy': workBy,
    'workDetail': workDetail,
    'tentativeAmount': tentativeAmount,
    'remark': remark,
    'contact': contact.toJson(),
  };
}

/// 2) Pending Work Completion Demand Details
@immutable
class PendingCompletion {
  final String workBy;
  final String workDetail;
  final String actualAmount;
  final String remark;
  final ContactPair contact;
  const PendingCompletion({
    required this.workBy,
    required this.workDetail,
    required this.actualAmount,
    required this.remark,
    required this.contact,
  });

  factory PendingCompletion.fromJson(Map<String, dynamic> j) =>
      PendingCompletion(
        workBy: j['workBy'] ?? '',
        workDetail: j['workDetail'] ?? '',
        actualAmount: j['actualAmount'] ?? '',
        remark: j['remark'] ?? '',
        contact: ContactPair.fromJson(j['contact'] ?? const {}),
      );
  Map<String, dynamic> toJson() => {
    'workBy': workBy,
    'workDetail': workDetail,
    'actualAmount': actualAmount,
    'remark': remark,
    'contact': contact.toJson(),
  };
}

/// 3) Beneficiary Oriented Details
@immutable
class BeneficiaryOriented {
  final String workBy;
  final String departmentName;
  final String amount;
  final String remark;
  final ContactPair contact;
  const BeneficiaryOriented({
    required this.workBy,
    required this.departmentName,
    required this.amount,
    required this.remark,
    required this.contact,
  });

  factory BeneficiaryOriented.fromJson(Map<String, dynamic> j) =>
      BeneficiaryOriented(
        workBy: j['workBy'] ?? '',
        departmentName: j['departmentName'] ?? '',
        amount: j['amount'] ?? '',
        remark: j['remark'] ?? '',
        contact: ContactPair.fromJson(j['contact'] ?? const {}),
      );
  Map<String, dynamic> toJson() => {
    'workBy': workBy,
    'departmentName': departmentName,
    'amount': amount,
    'remark': remark,
    'contact': contact.toJson(),
  };
}

/// Location Detail
@immutable
class LocationDetail {
  final String district;
  final String block;
  final String villageWard;
  final String constituency;
  const LocationDetail({
    required this.district,
    required this.block,
    required this.villageWard,
    required this.constituency,
  });

  factory LocationDetail.fromJson(Map<String, dynamic> j) => LocationDetail(
    district: j['district'] ?? '',
    block: j['block'] ?? '',
    villageWard: j['villageWard'] ?? '',
    constituency: j['constituency'] ?? '',
  );
  Map<String, dynamic> toJson() => {
    'district': district,
    'block': block,
    'villageWard': villageWard,
    'constituency': constituency,
  };
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

/// Top-level item
@immutable
class ConstructionWorkModel {
  final String date; // "21 Sept 2025"
  final String workId; // "CTW0001"
  final String userId; // "ID4532568553"
  final String title; // "Construction Work"
  final String message; // message bubble content
  final WorkStage stage; // which section to show
  final String status; // Approved/Pending/Rejected (if needed)
  final LocationDetail location;
  final NewWorkDemand? newWork;
  final PendingCompletion? pending;
  final BeneficiaryOriented? beneficiary;
  final List<String> attachments;
  final List<UploadedDocument> uploadedDocuments;

  const ConstructionWorkModel({
    required this.date,
    required this.workId,
    required this.userId,
    required this.title,
    required this.message,
    required this.stage,
    required this.status,
    required this.location,
    this.newWork,
    this.pending,
    this.beneficiary,
    this.attachments = const [],
    this.uploadedDocuments = const [],
  });

  factory ConstructionWorkModel.fromJson(Map<String, dynamic> j) =>
      ConstructionWorkModel(
        date: j['date'] ?? '',
        workId: j['workId'] ?? '',
        userId: j['userId'] ?? '',
        title: j['title'] ?? 'Construction Work',
        message: j['message'] ?? '',
        stage: workStageFrom(j['stage'] ?? 'newDemand'),
        status: j['status'] ?? 'Pending',
        location: LocationDetail.fromJson(j['location'] ?? const {}),
        newWork: j['newWork'] != null
            ? NewWorkDemand.fromJson(j['newWork'])
            : null,
        pending: j['pending'] != null
            ? PendingCompletion.fromJson(j['pending'])
            : null,
        beneficiary: j['beneficiary'] != null
            ? BeneficiaryOriented.fromJson(j['beneficiary'])
            : null,
        attachments: (j['attachments'] as List<dynamic>? ?? []).cast<String>(),
        uploadedDocuments: (j['uploadedDocuments'] as List<dynamic>? ?? [])
            .map((doc) => UploadedDocument.fromJson(doc))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'workId': workId,
    'userId': userId,
    'title': title,
    'message': message,
    'stage': workStageTo(stage),
    'status': status,
    'location': location.toJson(),
    'newWork': newWork?.toJson(),
    'pending': pending?.toJson(),
    'beneficiary': beneficiary?.toJson(),
    'attachments': attachments,
    'uploadedDocuments': uploadedDocuments.map((doc) => doc.toJson()).toList(),
  };
}
