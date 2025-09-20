import 'dart:convert';
import 'package:admin_jantasewa/models/authorized_user_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthorizedUserController extends GetxController {
  final RxList<AuthorizedUserModel> userList = <AuthorizedUserModel>[].obs;
  final RxList<AuthorizedUserModel> filteredList = <AuthorizedUserModel>[].obs;
  final RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final raw = await rootBundle.loadString('assets/data/authorized_user_data.json');
   final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    final data = list.map((e) => AuthorizedUserModel.fromJson(e)).toList();
   userList.assignAll(data);
    apply();
  }

  void setSearch(String v) {
    searchText.value = v;
    apply();
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    apply();
  }

  void apply() {
    List<AuthorizedUserModel> results = List.from(userList);
    final q = searchText.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      results = results.where((u) {
        return u.name.toLowerCase().contains(q) ||
            u.userId.toLowerCase().contains(q) ||
            u.phone.toLowerCase().contains(q);
      }).toList();
    }
    filteredList.assignAll(results);
  }
}
