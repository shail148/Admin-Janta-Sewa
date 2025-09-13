import 'package:flutter/foundation.dart';

@immutable
class UserModel {
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
  final String vidhansabha;
  final String cityVillage;
  final String wardNumber;
  final String pincode;
  final String accountCreated;
  final String lastLogin;
  final String status;
  final String profileImageUrl;

  const UserModel({
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
    required this.vidhansabha,
    required this.cityVillage,
    required this.wardNumber,
    required this.pincode,
    required this.accountCreated,
    required this.lastLogin,
    required this.status,
    required this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
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
    vidhansabha: j['vidhansabha'] ?? '',
    cityVillage: j['cityVillage'] ?? '',
    wardNumber: j['wardNumber'] ?? '',
    pincode: j['pincode'] ?? '',
    accountCreated: j['accountCreated'] ?? '',
    lastLogin: j['lastLogin'] ?? '',
    status: j['status'] ?? '',
    profileImageUrl: j['profileImageUrl'] ?? '',
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
    'vidhansabha': vidhansabha,
    'cityVillage': cityVillage,
    'wardNumber': wardNumber,
    'pincode': pincode,
    'accountCreated': accountCreated,
    'lastLogin': lastLogin,
    'status': status,
    'profileImageUrl': profileImageUrl,
  };
}
