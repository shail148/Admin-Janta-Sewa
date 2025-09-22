import 'dart:convert';
import 'package:admin_jantasewa/models/ticket/ticket_model.dart';
import 'package:admin_jantasewa/shared/user_detail_bottom_sheet/user_detail_bottom_sheet_model.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // to load JSON

class UserDetailBottomSheetController extends GetxController {
  var userDetails = {}.obs;
  var userHistory = <UserDetailBottomSheetModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final String response = await rootBundle.loadString(
      'assets/data/user_details_bottomsheet_data.json',
    );
    final data = jsonDecode(response);

    userDetails.value = data['userDetails'];
    userHistory.value = (data['userHistory'] as List)
        .map((e) => UserDetailBottomSheetModel.fromJson(e))
        .toList();
  }
}

/* import 'dart:convert';
import 'package:admin_jantasewa/models/ticket/ticket_model.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // to load JSON

class UserDetailBottomSheetController extends GetxController {
  var userDetails = {}.obs;
  var userHistory = <TicketModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() async {
    // Load data from the JSON file
    final String response = await rootBundle.loadString('assets/data/user_details_bottomsheet_data.json');
    final data = jsonDecode(response);

    // Set user details and history from JSON
    userDetails.value = data['userDetails'];
    userHistory.value = (data['userHistory'] as List).map((e) => TicketModel.fromJson(e)).toList();
  }
} */
