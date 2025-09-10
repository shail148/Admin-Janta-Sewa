import 'package:flutter/foundation.dart';

@immutable
class SuggestionLetterLocation {
  final String district;
  final String block;
  final String villageWard;
  final String constituency;
  const SuggestionLetterLocation({
    required this.district,
    required this.block,
    required this.villageWard,
    required this.constituency,
  });

  factory SuggestionLetterLocation.fromJson(Map<String, dynamic> j) =>
      SuggestionLetterLocation(
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

class BenefitSuggestion {
  final String benefitName;
  final String description;
  final String remark;
  const BenefitSuggestion({
    required this.benefitName,
    required this.description,
    required this.remark,
  });
  factory BenefitSuggestion.fromJson(Map<String, dynamic> j) =>
      BenefitSuggestion(
        benefitName: j['benefitName'] ?? '',
        description: j['description'] ?? '',
        remark: j['remark'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'benefitName': benefitName,
    'description': description,
    'remark': remark,
  };
}

class SchemeSuggestion {
  final String schemeName;
  final String eligibility;
  final String remark;
  const SchemeSuggestion({
    required this.schemeName,
    required this.eligibility,
    required this.remark,
  });
  factory SchemeSuggestion.fromJson(Map<String, dynamic> j) => SchemeSuggestion(
    schemeName: j['schemeName'] ?? '',
    eligibility: j['eligibility'] ?? '',
    remark: j['remark'] ?? '',
  );
  Map<String, dynamic> toJson() => {
    'schemeName': schemeName,
    'eligibility': eligibility,
    'remark': remark,
  };
}

class GovDepartmentSuggestion {
  final String departmentName;
  final String issue;
  final String remark;
  const GovDepartmentSuggestion({
    required this.departmentName,
    required this.issue,
    required this.remark,
  });
  factory GovDepartmentSuggestion.fromJson(Map<String, dynamic> j) =>
      GovDepartmentSuggestion(
        departmentName: j['departmentName'] ?? '',
        issue: j['issue'] ?? '',
        remark: j['remark'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'departmentName': departmentName,
    'issue': issue,
    'remark': remark,
  };
}

@immutable
class SuggestionLetterModel {
  final String date;
  final String letterId;
  final String userId;
  final String title;
  final String message;
  final String status;
  final SuggestionLetterLocation location;
  final Map<String, dynamic> details;
  final List<String> attachments;
  final List<UploadedDocument> uploadedDocuments;
  final BenefitSuggestion? benefit;
  final SchemeSuggestion? scheme;
  final GovDepartmentSuggestion? govDepartment;

  const SuggestionLetterModel({
    required this.date,
    required this.letterId,
    required this.userId,
    required this.title,
    required this.message,
    required this.status,
    required this.location,
    required this.details,
    this.attachments = const [],
    this.uploadedDocuments = const [],
    this.benefit,
    this.scheme,
    this.govDepartment,
  });

  factory SuggestionLetterModel.fromJson(Map<String, dynamic> j) =>
      SuggestionLetterModel(
        date: j['date'] ?? '',
        letterId: j['letterId'] ?? '',
        userId: j['userId'] ?? '',
        title: j['title'] ?? 'Suggestion Letter',
        message: j['message'] ?? '',
        status: j['status'] ?? 'Pending',
        location: SuggestionLetterLocation.fromJson(j['location'] ?? const {}),
        details: j['details'] ?? {},
        attachments: (j['attachments'] as List<dynamic>? ?? []).cast<String>(),
        uploadedDocuments: (j['uploadedDocuments'] as List<dynamic>? ?? [])
            .map((doc) => UploadedDocument.fromJson(doc))
            .toList(),
        benefit: j['benefit'] != null
            ? BenefitSuggestion.fromJson(j['benefit'])
            : null,
        scheme: j['scheme'] != null
            ? SchemeSuggestion.fromJson(j['scheme'])
            : null,
        govDepartment: j['govDepartment'] != null
            ? GovDepartmentSuggestion.fromJson(j['govDepartment'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'letterId': letterId,
    'userId': userId,
    'title': title,
    'message': message,
    'status': status,
    'location': location.toJson(),
    'details': details,
    'attachments': attachments,
    'uploadedDocuments': uploadedDocuments.map((doc) => doc.toJson()).toList(),
    'benefit': benefit?.toJson(),
    'scheme': scheme?.toJson(),
    'govDepartment': govDepartment?.toJson(),
  };
}
