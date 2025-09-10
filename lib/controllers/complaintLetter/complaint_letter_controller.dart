import 'dart:convert';
import 'package:admin_jantasewa/models/complaintLetter/complaint_letter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class ComplaintLetterController extends GetxController {
  final RxList<ComplaintLetterModel> complaintList =
      <ComplaintLetterModel>[].obs;
  final RxList<ComplaintLetterModel> filteredList =
      <ComplaintLetterModel>[].obs;

  final RxString selectedFilter = 'All'.obs;
  final RxString selectedSort = 'Newest'.obs;
  final RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadComplaints();
  }

  Future<void> loadComplaints() async {
    final raw = await rootBundle.loadString(
      'assets/data/complaint_letters.json',
    );
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    final data = list
        .map((e) => ComplaintLetterModel.fromJson(e as Map<String, dynamic>))
        .toList();
    complaintList.assignAll(data);
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

  void setStatusFilter(String v) {
    selectedFilter.value = v;
    apply();
  }

  void setSort(String v) {
    selectedSort.value = v;
    apply();
  }

  void apply() {
    List<ComplaintLetterModel> results = List.from(complaintList);
    final q = searchText.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      results = results.where((t) {
        return t.complaintId.toLowerCase().contains(q) ||
            t.userId.toLowerCase().contains(q) ||
            t.title.toLowerCase().contains(q) ||
            t.message.toLowerCase().contains(q);
      }).toList();
    }
    if (selectedFilter.value != 'All') {
      results = results.where((t) => t.status == selectedFilter.value).toList();
    }
    switch (selectedSort.value) {
      case 'Newest':
        results.sort(
          (a, b) => _parseDate(b.date).compareTo(_parseDate(a.date)),
        );
        break;
      case 'Oldest':
        results.sort(
          (a, b) => _parseDate(a.date).compareTo(_parseDate(b.date)),
        );
        break;
    }
    filteredList.assignAll(results);
  }

  Color statusColor(String s) {
    switch (s) {
      case 'Approved':
        return const Color(0xFF16A34A);
      case 'Pending':
        return const Color(0xFFF59E0B);
      case 'Rejected':
        return const Color(0xFFDC2626);
      default:
        return Colors.grey;
    }
  }

  int statusBadgeCount(String status) => status == 'All'
      ? complaintList.length
      : complaintList.where((t) => t.status == status).length;

  DateTime _parseDate(String isoOrPretty) {
    try {
      return DateTime.parse(isoOrPretty);
    } catch (_) {}
    try {
      final p = isoOrPretty.split(' ');
      if (p.length >= 3) {
        final d = int.tryParse(p[0]) ?? 1;
        final y = int.tryParse(p[2]) ?? DateTime.now().year;
        const mMap = {
          'Jan': 1,
          'Feb': 2,
          'Mar': 3,
          'Apr': 4,
          'May': 5,
          'Jun': 6,
          'Jul': 7,
          'Aug': 8,
          'Sep': 9,
          'Sept': 9,
          'Oct': 10,
          'Nov': 11,
          'Dec': 12,
        };
        final m = mMap[p[1]] ?? 1;
        return DateTime(y, m, d);
      }
    } catch (_) {}
    return DateTime.now();
  }
}
