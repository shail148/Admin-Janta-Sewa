import 'dart:convert';
import 'package:admin_jantasewa/models/budgetDemand/budget_demand_model.dart';
import 'package:admin_jantasewa/shared/chart_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class BudgetDemandController extends GetxController {
  // ---------------- Source / UI lists ----------------
  final RxList<BudgetDemandModel> demandList = <BudgetDemandModel>[].obs;
  final RxList<BudgetDemandModel> filteredList = <BudgetDemandModel>[].obs;

  // ---------------- Filters / Search / Sort ----------------
  final RxString selectedFilter =
      'All'.obs; // All | Approved | Pending | Rejected
  final RxString selectedSort = 'Newest'.obs; // Newest | Oldest
  final RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // ---------------- Chart state (multi-series) ----------------
  final Rx<ChartRange> chartRange = ChartRange.week.obs;
  final RxList<String> graphLabels = <String>[].obs; // x-axis labels
  final RxList<FlSpot> approvedSpots = <FlSpot>[].obs;
  final RxList<FlSpot> pendingSpots = <FlSpot>[].obs;
  final RxList<FlSpot> rejectedSpots = <FlSpot>[].obs;

  // Legacy single-series (optional)
  final RxList<FlSpot> graphPoints = <FlSpot>[].obs;

  // ---------------- Lifecycle ----------------
  @override
  void onInit() {
    super.onInit();
    loadDemands();
  }

  // ---------------- Data load (JSON asset) ----------------
  Future<void> loadDemands() async {
    // Path: assets/data/budget_demand.json
    final raw = await rootBundle.loadString(
      'assets/data/budget_demand_100.json',
    );
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;

    final data = list
        .map((e) => BudgetDemandModel.fromJson(e as Map<String, dynamic>))
        .toList();

    demandList.assignAll(data);
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
    List<BudgetDemandModel> results = List.from(demandList);

    // Search across useful fields
    final q = searchText.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      results = results.where((d) {
        return d.budgetDemandId.toLowerCase().contains(q) ||
            d.userId.toLowerCase().contains(q) ||
            d.reason.toLowerCase().contains(q) ||
            d.officeWorkDetail.applicantName.toLowerCase().contains(q) ||
            d.officeWorkDetail.departmentName.toLowerCase().contains(q) ||
            d.officeWorkDetail.requestFor.toLowerCase().contains(q);
      }).toList();
    }

    // Filter by status
    if (selectedFilter.value != 'All') {
      results = results.where((d) => d.status == selectedFilter.value).toList();
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
  void _rebuildChartSeries(List<BudgetDemandModel> list) {
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
          for (final d in list) {
            final dt = _parseDate(d.requestDate);
            if (dt.year == day.year &&
                dt.month == day.month &&
                dt.day == day.day) {
              if (d.status == 'Approved') {
                a[i]++;
              } else if (d.status == 'Pending') {
                p[i]++;
              } else if (d.status == 'Rejected') {
                r[i]++;
              }
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

        for (final d in list) {
          final dt = _parseDate(d.requestDate);
          if (dt.year == first.year && dt.month == first.month) {
            final idx = dt.day - 1;
            if (idx >= 0 && idx < days) {
              if (d.status == 'Approved') {
                a[idx]++;
              } else if (d.status == 'Pending') {
                p[idx]++;
              } else if (d.status == 'Rejected') {
                r[idx]++;
              }
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

        for (final d in list) {
          final dt = _parseDate(d.requestDate);
          if (dt.year == now.year) {
            final idx = dt.month - 1;
            if (d.status == 'Approved') {
              a[idx]++;
            } else if (d.status == 'Pending') {
              p[idx]++;
            } else if (d.status == 'Rejected') {
              r[idx]++;
            }
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

  void _rebuildSingleSeries(List<BudgetDemandModel> list) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: (now.weekday + 6) % 7));
    final counts = List<int>.filled(7, 0);

    for (int i = 0; i < 7; i++) {
      final day = monday.add(Duration(days: i));
      for (final d in list) {
        final dt = _parseDate(d.requestDate);
        if (dt.year == day.year && dt.month == day.month && dt.day == day.day) {
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
      ? demandList.length
      : demandList.where((t) => t.status == status).length;

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
