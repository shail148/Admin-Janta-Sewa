import 'dart:convert';
import 'package:admin_jantasewa/shared/chart_range.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:admin_jantasewa/models/hospital/hospital_admission_model.dart';

class HospitalAdmissionController extends GetxController {
  // ---------------- Source / UI lists ----------------
  final RxList<HospitalAdmissionModel> admissionList =
      <HospitalAdmissionModel>[].obs;
  final RxList<HospitalAdmissionModel> filteredList =
      <HospitalAdmissionModel>[].obs;

  // ---------------- Filters / Search / Sort ----------------
  final RxString selectedFilter =
      'All'.obs; // All | Approved | Pending | Rejected
  final RxString selectedSort = 'Newest'.obs; // Newest | Oldest
  final RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // ---------------- Chart state (multi-series) ----------------
  final Rx<ChartRange> chartRange = ChartRange.week.obs;
  final RxList<String> graphLabels = <String>[].obs; // x-axis
  final RxList<FlSpot> approvedSpots = <FlSpot>[].obs; // green
  final RxList<FlSpot> pendingSpots = <FlSpot>[].obs; // amber
  final RxList<FlSpot> rejectedSpots = <FlSpot>[].obs; // red

  // (optional legacy single-series)
  final RxList<FlSpot> graphPoints = <FlSpot>[].obs;

  // ---------------- Lifecycle ----------------
  @override
  void onInit() {
    super.onInit();
    loadAdmissions();
  }

  // ---------------- Data load (JSON asset) ----------------
  Future<void> loadAdmissions() async {
    // Path: assets/data/hospital_admissions.json
    final raw = await rootBundle.loadString(
      'assets/data/hospital_admission_500.json',
    );
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    final data = list
        .map((e) => HospitalAdmissionModel.fromJson(e as Map<String, dynamic>))
        .toList();

    admissionList.assignAll(data);
    apply(); // initial filter + chart build
  }

  // ---------------- Public API (UI actions) ----------------
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

  void setChartRange(ChartRange r) {
    if (chartRange.value == r) return;
    chartRange.value = r;
    _rebuildChartSeries(filteredList);
  }

  // ---------------- Pipeline (search → filter → sort → chart) ----------------
  void apply() {
    List<HospitalAdmissionModel> results = List.from(admissionList);

    // Search across useful fields
    final q = searchText.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      results = results.where((a) {
        return a.requestId.toLowerCase().contains(q) ||
            a.userId.toLowerCase().contains(q) ||
            a.patientName.toLowerCase().contains(q) ||
            a.patientGender.toLowerCase().contains(q) ||
            a.admissionType.toLowerCase().contains(q) ||
            a.diseaseName.toLowerCase().contains(q) ||
            a.hospitalName.toLowerCase().contains(q) ||
            a.hospitalAddress.toLowerCase().contains(q) ||
            a.hospitalContactPerson.toLowerCase().contains(q) ||
            a.hospitalContactMobile.toLowerCase().contains(q) ||
            a.reason.toLowerCase().contains(q) ||
            a.attendentName.toLowerCase().contains(q);
      }).toList();
    }

    // Filter by status
    if (selectedFilter.value != 'All') {
      results = results.where((a) => a.status == selectedFilter.value).toList();
    }

    // Sort by requestDate
    switch (selectedSort.value) {
      case 'Newest':
        results.sort(
          (a, b) =>
              _parseDate(b.requestDate).compareTo(_parseDate(a.requestDate)),
        );
        break;
      case 'Oldest':
        results.sort(
          (a, b) =>
              _parseDate(a.requestDate).compareTo(_parseDate(b.requestDate)),
        );
        break;
    }

    filteredList.assignAll(results);

    // Charts
    _rebuildChartSeries(results);
    _rebuildSingleSeries(results);
  }

  // ---------------- Chart builders ----------------
  void _rebuildChartSeries(List<HospitalAdmissionModel> list) {
    switch (chartRange.value) {
      case ChartRange.week:
        final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        final a = List<int>.filled(7, 0);
        final p = List<int>.filled(7, 0);
        final r = List<int>.filled(7, 0);

        final now = DateTime.now();
        final monday = now.subtract(Duration(days: (now.weekday + 6) % 7));

        for (int i = 0; i < 7; i++) {
          final day = monday.add(Duration(days: i));
          for (final t in list) {
            final d = _parseDate(t.requestDate);
            if (d.year == day.year &&
                d.month == day.month &&
                d.day == day.day) {
              if (t.status == 'Approved')
                a[i]++;
              else if (t.status == 'Pending')
                p[i]++;
              else if (t.status == 'Rejected')
                r[i]++;
            }
          }
        }

        graphLabels.assignAll(labels);
        approvedSpots.assignAll([
          for (int i = 0; i < 7; i++) FlSpot(i.toDouble(), a[i].toDouble()),
        ]);
        pendingSpots.assignAll([
          for (int i = 0; i < 7; i++) FlSpot(i.toDouble(), p[i].toDouble()),
        ]);
        rejectedSpots.assignAll([
          for (int i = 0; i < 7; i++) FlSpot(i.toDouble(), r[i].toDouble()),
        ]);
        break;

      case ChartRange.month:
        final now = DateTime.now();
        final first = DateTime(now.year, now.month, 1);
        final days = DateTime(now.year, now.month + 1, 0).day;

        final a = List<int>.filled(days, 0);
        final p = List<int>.filled(days, 0);
        final r = List<int>.filled(days, 0);
        final labels = List<String>.generate(days, (i) => (i + 1).toString());

        for (final t in list) {
          final d = _parseDate(t.requestDate);
          if (d.year == first.year && d.month == first.month) {
            final idx = d.day - 1;
            if (idx >= 0 && idx < days) {
              if (t.status == 'Approved')
                a[idx]++;
              else if (t.status == 'Pending')
                p[idx]++;
              else if (t.status == 'Rejected')
                r[idx]++;
            }
          }
        }

        graphLabels.assignAll(labels);
        approvedSpots.assignAll([
          for (int i = 0; i < days; i++) FlSpot(i.toDouble(), a[i].toDouble()),
        ]);
        pendingSpots.assignAll([
          for (int i = 0; i < days; i++) FlSpot(i.toDouble(), p[i].toDouble()),
        ]);
        rejectedSpots.assignAll([
          for (int i = 0; i < days; i++) FlSpot(i.toDouble(), r[i].toDouble()),
        ]);
        break;

      case ChartRange.year:
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        final a = List<int>.filled(12, 0);
        final p = List<int>.filled(12, 0);
        final r = List<int>.filled(12, 0);
        final now = DateTime.now();

        for (final t in list) {
          final d = _parseDate(t.requestDate);
          if (d.year == now.year) {
            final idx = d.month - 1;
            if (t.status == 'Approved')
              a[idx]++;
            else if (t.status == 'Pending')
              p[idx]++;
            else if (t.status == 'Rejected')
              r[idx]++;
          }
        }

        graphLabels.assignAll(months);
        approvedSpots.assignAll([
          for (int i = 0; i < 12; i++) FlSpot(i.toDouble(), a[i].toDouble()),
        ]);
        pendingSpots.assignAll([
          for (int i = 0; i < 12; i++) FlSpot(i.toDouble(), p[i].toDouble()),
        ]);
        rejectedSpots.assignAll([
          for (int i = 0; i < 12; i++) FlSpot(i.toDouble(), r[i].toDouble()),
        ]);
        break;
    }
  }

  // Optional: total series for current week
  void _rebuildSingleSeries(List<HospitalAdmissionModel> list) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: (now.weekday + 6) % 7));
    final counts = List<int>.filled(7, 0);

    for (int i = 0; i < 7; i++) {
      final day = monday.add(Duration(days: i));
      for (final t in list) {
        final d = _parseDate(t.requestDate);
        if (d.year == day.year && d.month == day.month && d.day == day.day) {
          counts[i]++;
        }
      }
    }
    graphPoints.assignAll([
      for (int i = 0; i < 7; i++) FlSpot(i.toDouble(), counts[i].toDouble()),
    ]);
  }

  // ---------------- Helpers ----------------
  int statusBadgeCount(String status) => status == 'All'
      ? admissionList.length
      : admissionList.where((t) => t.status == status).length;

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

  DateTime _parseDate(String iso) {
    try {
      return DateTime.parse(iso);
    } catch (_) {
      return DateTime.now();
    }
  }
}
