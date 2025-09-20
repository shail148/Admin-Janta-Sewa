import 'package:flutter/foundation.dart';

@immutable
class AuthorizedUserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String dob;
  final String gender;
  final String nationality;
  final String address;
  final String state;
  final String district;
  final String block;
  final String cityVillage;
  final String wardNumber;
  final String pincode;
  final String accountCreated;
  final String lastLogin;
  final String status;
  final String profileImageUrl;
  final String selectedPost;
  final String forwardedLevel;

  const AuthorizedUserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.nationality,
    required this.address,
    required this.state,
    required this.district,
    required this.block,
    required this.cityVillage,
    required this.wardNumber,
    required this.pincode,
    required this.accountCreated,
    required this.lastLogin,
    required this.status,
    required this.profileImageUrl,
    required this.selectedPost,
    required this.forwardedLevel,
  });

  factory AuthorizedUserModel.fromJson(Map<String, dynamic> j) => AuthorizedUserModel(
    userId: j['userId'] ?? '',
    name: j['name'] ?? '',
    email: j['email'] ?? '',
    phone: j['phone'] ?? '',
    dob: j['dob'] ?? '',
    gender: j['gender'] ?? '',
    nationality: j['nationality'] ?? '',
    address: j['address'] ?? '',
    state: j['state'] ?? '',
    district: j['district'] ?? '',
    block: j['block'] ?? '',
    cityVillage: j['cityVillage'] ?? '',
    wardNumber: j['wardNumber'] ?? '',
    pincode: j['pincode'] ?? '',
    accountCreated: j['accountCreated'] ?? '',
    lastLogin: j['lastLogin'] ?? '',
    status: j['status'] ?? '',
    profileImageUrl: j['profileImageUrl'] ?? '',
    selectedPost: j['selectedPost'] ?? '',
    forwardedLevel: j['forwardedLevel'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'email': email,
    'phone': phone,
    'dob': dob,
    'gender': gender,
    'nationality': nationality,
    'address': address,
    'state': state,
    'district': district,
    'block': block,
    'cityVillage': cityVillage,
    'wardNumber': wardNumber,
    'pincode': pincode,
    'accountCreated': accountCreated,
    'lastLogin': lastLogin,
    'status': status,
    'profileImageUrl': profileImageUrl,
    'selectedPost': selectedPost,
    'forwardedLevel': forwardedLevel,
  };
}
