import 'package:flutter/foundation.dart';

@immutable
class UploadedDocument {
  final String fileName;
  final String fileSize;
  const UploadedDocument({required this.fileName, required this.fileSize});
  factory UploadedDocument.fromJson(Map<String, dynamic> json) =>
      UploadedDocument(
        fileName: json['fileName'] ?? '',
        fileSize: json['fileSize'] ?? '',
      );
  Map<String, dynamic> toJson() => {'fileName': fileName, 'fileSize': fileSize};
}

// Each type below is a separate class, only one is non-null per Recommendation
class CulturalProgrammeDetails {
  final String applicantName;
  final String mobileNumber;
  final String hostDetail;
  final String date;
  final String culturalProgrammeName;
  final String inLetterOf;
  final String address;
  const CulturalProgrammeDetails({
    required this.applicantName,
    required this.mobileNumber,
    required this.hostDetail,
    required this.date,
    required this.culturalProgrammeName,
    required this.inLetterOf,
    required this.address,
  });
  factory CulturalProgrammeDetails.fromJson(Map<String, dynamic> j) =>
      CulturalProgrammeDetails(
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        hostDetail: j['hostDetail'] ?? '',
        date: j['date'] ?? '',
        culturalProgrammeName: j['culturalProgrammeName'] ?? '',
        inLetterOf: j['inLetterOf'] ?? '',
        address: j['address'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'hostDetail': hostDetail,
    'date': date,
    'culturalProgrammeName': culturalProgrammeName,
    'inLetterOf': inLetterOf,
    'address': address,
  };
}

class TransferDetails {
  final String typeOfTransfer;
  final String applicantName;
  final String mobileNumber;
  final String designation;
  final String department;
  final String postOffice;
  final String optedOffice;
  final String reasonForTransfer;
  final String address;
  const TransferDetails({
    required this.typeOfTransfer,
    required this.applicantName,
    required this.mobileNumber,
    required this.designation,
    required this.department,
    required this.postOffice,
    required this.optedOffice,
    required this.reasonForTransfer,
    required this.address,
  });
  factory TransferDetails.fromJson(Map<String, dynamic> j) => TransferDetails(
    typeOfTransfer: j['typeOfTransfer'] ?? '',
    applicantName: j['applicantName'] ?? '',
    mobileNumber: j['mobileNumber'] ?? '',
    designation: j['designation'] ?? '',
    department: j['department'] ?? '',
    postOffice: j['postOffice'] ?? '',
    optedOffice: j['optedOffice'] ?? '',
    reasonForTransfer: j['reasonForTransfer'] ?? '',
    address: j['address'] ?? '',
  );
  Map<String, dynamic> toJson() => {
    'typeOfTransfer': typeOfTransfer,
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'designation': designation,
    'department': department,
    'postOffice': postOffice,
    'optedOffice': optedOffice,
    'reasonForTransfer': reasonForTransfer,
    'address': address,
  };
}

class PostingDetails {
  final String typeOfPosting;
  final String applicantName;
  final String mobileNumber;
  final String designation;
  final String department;
  final String postOffice;
  final String optedOffice;
  final String reasonForPosting;
  final String address;
  const PostingDetails({
    required this.typeOfPosting,
    required this.applicantName,
    required this.mobileNumber,
    required this.designation,
    required this.department,
    required this.postOffice,
    required this.optedOffice,
    required this.reasonForPosting,
    required this.address,
  });
  factory PostingDetails.fromJson(Map<String, dynamic> j) => PostingDetails(
    typeOfPosting: j['typeOfPosting'] ?? '',
    applicantName: j['applicantName'] ?? '',
    mobileNumber: j['mobileNumber'] ?? '',
    designation: j['designation'] ?? '',
    department: j['department'] ?? '',
    postOffice: j['postOffice'] ?? '',
    optedOffice: j['optedOffice'] ?? '',
    reasonForPosting: j['reasonForPosting'] ?? '',
    address: j['address'] ?? '',
  );
  Map<String, dynamic> toJson() => {
    'typeOfPosting': typeOfPosting,
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'designation': designation,
    'department': department,
    'postOffice': postOffice,
    'optedOffice': optedOffice,
    'reasonForPosting': reasonForPosting,
    'address': address,
  };
}

class QuarterAllotmentDetails {
  final String typeOfAllotment;
  final String fullName;
  final String mobileNumber;
  final String department;
  final String optedOffice;
  final String reasonForAllotment;
  final String address;
  const QuarterAllotmentDetails({
    required this.typeOfAllotment,
    required this.fullName,
    required this.mobileNumber,
    required this.department,
    required this.optedOffice,
    required this.reasonForAllotment,
    required this.address,
  });
  factory QuarterAllotmentDetails.fromJson(Map<String, dynamic> j) =>
      QuarterAllotmentDetails(
        typeOfAllotment: j['typeOfAllotment'] ?? '',
        fullName: j['fullName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        department: j['department'] ?? '',
        optedOffice: j['optedOffice'] ?? '',
        reasonForAllotment: j['reasonForAllotment'] ?? '',
        address: j['address'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'typeOfAllotment': typeOfAllotment,
    'fullName': fullName,
    'mobileNumber': mobileNumber,
    'department': department,
    'optedOffice': optedOffice,
    'reasonForAllotment': reasonForAllotment,
    'address': address,
  };
}

class AwardDetails {
  final String typeOfAward;
  final String applicantName;
  final String mobileNumber;
  final String careerAchievement;
  final String awardName;
  final String briefDetail;
  final String address;
  const AwardDetails({
    required this.typeOfAward,
    required this.applicantName,
    required this.mobileNumber,
    required this.careerAchievement,
    required this.awardName,
    required this.briefDetail,
    required this.address,
  });
  factory AwardDetails.fromJson(Map<String, dynamic> j) => AwardDetails(
    typeOfAward: j['typeOfAward'] ?? '',
    applicantName: j['applicantName'] ?? '',
    mobileNumber: j['mobileNumber'] ?? '',
    careerAchievement: j['careerAchievement'] ?? '',
    awardName: j['awardName'] ?? '',
    briefDetail: j['briefDetail'] ?? '',
    address: j['address'] ?? '',
  );
  Map<String, dynamic> toJson() => {
    'typeOfAward': typeOfAward,
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'careerAchievement': careerAchievement,
    'awardName': awardName,
    'briefDetail': briefDetail,
    'address': address,
  };
}

class AdmissionDetails {
  final String typeOfAdmission;
  final String applicantName;
  final String mobileNumber;
  final String studentName;
  final String classCourse;
  final String address;
  const AdmissionDetails({
    required this.typeOfAdmission,
    required this.applicantName,
    required this.mobileNumber,
    required this.studentName,
    required this.classCourse,
    required this.address,
  });
  factory AdmissionDetails.fromJson(Map<String, dynamic> j) => AdmissionDetails(
    typeOfAdmission: j['typeOfAdmission'] ?? '',
    applicantName: j['applicantName'] ?? '',
    mobileNumber: j['mobileNumber'] ?? '',
    studentName: j['studentName'] ?? '',
    classCourse: j['classCourse'] ?? '',
    address: j['address'] ?? '',
  );
  Map<String, dynamic> toJson() => {
    'typeOfAdmission': typeOfAdmission,
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'studentName': studentName,
    'classCourse': classCourse,
    'address': address,
  };
}

class LandAllotmentDetails {
  final String applicantName;
  final String mobileNumber;
  final String optedDepartment;
  final String optedLandOffice;
  final String reasonForLandAllotment;
  final String address;
  const LandAllotmentDetails({
    required this.applicantName,
    required this.mobileNumber,
    required this.optedDepartment,
    required this.optedLandOffice,
    required this.reasonForLandAllotment,
    required this.address,
  });
  factory LandAllotmentDetails.fromJson(Map<String, dynamic> j) =>
      LandAllotmentDetails(
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        optedDepartment: j['optedDepartment'] ?? '',
        optedLandOffice: j['optedLandOffice'] ?? '',
        reasonForLandAllotment: j['reasonForLandAllotment'] ?? '',
        address: j['address'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'optedDepartment': optedDepartment,
    'optedLandOffice': optedLandOffice,
    'reasonForLandAllotment': reasonForLandAllotment,
    'address': address,
  };
}

class JobRecommendationDetails {
  final String jobRecommendationType;
  final String applicantName;
  final String mobileNumber;
  final String postName;
  final String department;
  final String address;
  const JobRecommendationDetails({
    required this.jobRecommendationType,
    required this.applicantName,
    required this.mobileNumber,
    required this.postName,
    required this.department,
    required this.address,
  });
  factory JobRecommendationDetails.fromJson(Map<String, dynamic> j) =>
      JobRecommendationDetails(
        jobRecommendationType: j['jobRecommendationType'] ?? '',
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        postName: j['postName'] ?? '',
        department: j['department'] ?? '',
        address: j['address'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'jobRecommendationType': jobRecommendationType,
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'postName': postName,
    'department': department,
    'address': address,
  };
}

class FinancialRecommendationDetails {
  final String department;
  final String applicantName;
  final String mobileNumber;
  final String reasonOfProblem;
  final String tentativeAmount;
  final String address;
  const FinancialRecommendationDetails({
    required this.department,
    required this.applicantName,
    required this.mobileNumber,
    required this.reasonOfProblem,
    required this.tentativeAmount,
    required this.address,
  });
  factory FinancialRecommendationDetails.fromJson(Map<String, dynamic> j) =>
      FinancialRecommendationDetails(
        department: j['department'] ?? '',
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        reasonOfProblem: j['reasonOfProblem'] ?? '',
        tentativeAmount: j['tentativeAmount'] ?? '',
        address: j['address'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'department': department,
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'reasonOfProblem': reasonOfProblem,
    'tentativeAmount': tentativeAmount,
    'address': address,
  };
}

class OtherRecommendationDetails {
  final String applicantName;
  final String mobileNumber;
  final String recommendationNeed;
  final String address;
  const OtherRecommendationDetails({
    required this.applicantName,
    required this.mobileNumber,
    required this.recommendationNeed,
    required this.address,
  });
  factory OtherRecommendationDetails.fromJson(Map<String, dynamic> j) =>
      OtherRecommendationDetails(
        applicantName: j['applicantName'] ?? '',
        mobileNumber: j['mobileNumber'] ?? '',
        recommendationNeed: j['recommendationNeed'] ?? '',
        address: j['address'] ?? '',
      );
  Map<String, dynamic> toJson() => {
    'applicantName': applicantName,
    'mobileNumber': mobileNumber,
    'recommendationNeed': recommendationNeed,
    'address': address,
  };
}

@immutable
class RecommendationModel {
  final String date;
  final String recommendationId;
  final String userId;
  final String title;
  final String message;
  final String status;
  final CulturalProgrammeDetails? culturalProgramme;
  final TransferDetails? transfer;
  final PostingDetails? posting;
  final QuarterAllotmentDetails? quarterAllotment;
  final AwardDetails? award;
  final AdmissionDetails? admission;
  final LandAllotmentDetails? landAllotment;
  final JobRecommendationDetails? jobRecommendation;
  final FinancialRecommendationDetails? financialRecommendation;
  final OtherRecommendationDetails? otherRecommendation;
  final List<UploadedDocument> uploadedDocuments;
  const RecommendationModel({
    required this.date,
    required this.recommendationId,
    required this.userId,
    required this.title,
    required this.message,
    required this.status,
    this.culturalProgramme,
    this.transfer,
    this.posting,
    this.quarterAllotment,
    this.award,
    this.admission,
    this.landAllotment,
    this.jobRecommendation,
    this.financialRecommendation,
    this.otherRecommendation,
    required this.uploadedDocuments,
  });
  factory RecommendationModel.fromJson(Map<String, dynamic> j) =>
      RecommendationModel(
        date: j['date'] ?? '',
        recommendationId: j['recommendationId'] ?? '',
        userId: j['userId'] ?? '',
        title: j['title'] ?? '',
        message: j['message'] ?? '',
        status: j['status'] ?? '',
        culturalProgramme: j['culturalProgramme'] != null
            ? CulturalProgrammeDetails.fromJson(j['culturalProgramme'])
            : null,
        transfer: j['transfer'] != null
            ? TransferDetails.fromJson(j['transfer'])
            : null,
        posting: j['posting'] != null
            ? PostingDetails.fromJson(j['posting'])
            : null,
        quarterAllotment: j['quarterAllotment'] != null
            ? QuarterAllotmentDetails.fromJson(j['quarterAllotment'])
            : null,
        award: j['award'] != null ? AwardDetails.fromJson(j['award']) : null,
        admission: j['admission'] != null
            ? AdmissionDetails.fromJson(j['admission'])
            : null,
        landAllotment: j['landAllotment'] != null
            ? LandAllotmentDetails.fromJson(j['landAllotment'])
            : null,
        jobRecommendation: j['jobRecommendation'] != null
            ? JobRecommendationDetails.fromJson(j['jobRecommendation'])
            : null,
        financialRecommendation: j['financialRecommendation'] != null
            ? FinancialRecommendationDetails.fromJson(
                j['financialRecommendation'],
              )
            : null,
        otherRecommendation: j['otherRecommendation'] != null
            ? OtherRecommendationDetails.fromJson(j['otherRecommendation'])
            : null,
        uploadedDocuments: (j['uploadedDocuments'] as List<dynamic>? ?? [])
            .map((d) => UploadedDocument.fromJson(d))
            .toList(),
      );
  Map<String, dynamic> toJson() => {
    'date': date,
    'recommendationId': recommendationId,
    'userId': userId,
    'title': title,
    'message': message,
    'status': status,
    'culturalProgramme': culturalProgramme?.toJson(),
    'transfer': transfer?.toJson(),
    'posting': posting?.toJson(),
    'quarterAllotment': quarterAllotment?.toJson(),
    'award': award?.toJson(),
    'admission': admission?.toJson(),
    'landAllotment': landAllotment?.toJson(),
    'jobRecommendation': jobRecommendation?.toJson(),
    'financialRecommendation': financialRecommendation?.toJson(),
    'otherRecommendation': otherRecommendation?.toJson(),
    'uploadedDocuments': uploadedDocuments.map((d) => d.toJson()).toList(),
  };
}
