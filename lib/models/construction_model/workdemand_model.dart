class WorkDemandModel {
  final String workId;
  final String workName;
  final String workDetail;
  final String tentativeAmount;
  final String remark;
  final String demandedPerson;
  final String demandedPersonMobile;
  final String district;
  final String block;
  final String villageWard;
  final String constituency;
  final List<String> uploadedFiles;
  final String status; // Pending, Approved, Rejected
  final String requestedDate;

  WorkDemandModel({
    required this.workId,
    required this.workName,
    required this.workDetail,
    required this.tentativeAmount,
    required this.remark,
    required this.demandedPerson,
    required this.demandedPersonMobile,
    required this.district,
    required this.block,
    required this.villageWard,
    required this.constituency,
    required this.uploadedFiles,
    this.status = "Pending",
    required this.requestedDate,
  });

  factory WorkDemandModel.fromJson(Map<String, dynamic> json) {
    return WorkDemandModel(
      workId: json['workId'] ?? '',
      workName: json['workName'] ?? '',
      workDetail: json['workDetail'] ?? '',
      tentativeAmount: json['tentativeAmount'] ?? '',
      remark: json['remark'] ?? '',
      demandedPerson: json['demandedPerson'] ?? '',
      demandedPersonMobile: json['demandedPersonMobile'] ?? '',
      district: json['district'] ?? '',
      block: json['block'] ?? '',
      villageWard: json['villageWard'] ?? '',
      constituency: json['constituency'] ?? '',
      uploadedFiles: List<String>.from(json['uploadedFiles'] ?? []),
      status: json['status'] ?? 'Pending',
      requestedDate: json['requestedDate'] ?? '',
      //If we want add more then we can add more details
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workId': workId,
      'workName': workName,
      'workDetail': workDetail,
      'tentativeAmount': tentativeAmount,
      'remark': remark,
      'demandedPerson': demandedPerson,
      'demandedPersonMobile': demandedPersonMobile,
      'district': district,
      'block': block,
      'villageWard': villageWard,
      'constituency': constituency,
      'uploadedFiles': uploadedFiles,
      'status': status,
      'requestedDate': requestedDate,
    };
  }
}
