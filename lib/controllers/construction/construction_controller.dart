import 'dart:convert';
import 'package:admin_jantasewa/models/construction/construction_model.dart';
import 'package:admin_jantasewa/shared/chart_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class ConstructionWorkController extends GetxController {
  // ---------------- Source / UI lists ----------------
  final RxList<ConstructionWorkModel> workList = <ConstructionWorkModel>[].obs;
  final RxList<ConstructionWorkModel> filteredList =
      <ConstructionWorkModel>[].obs;

  // ---------------- Filters / Search / Sort ----------------
  final RxString selectedFilter =
      'All'.obs; // All | Approved | Pending | Rejected
  final RxString selectedSort = 'Newest'.obs; // Newest | Oldest
  final RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // ---------------- Chart state (multi-series by STATUS) ----------------
  final Rx<ChartRange> chartRange = ChartRange.week.obs;
  final RxList<String> graphLabels = <String>[].obs; // x-axis
  final RxList<FlSpot> approvedSpots = <FlSpot>[].obs;
  final RxList<FlSpot> pendingSpots = <FlSpot>[].obs;
  final RxList<FlSpot> rejectedSpots = <FlSpot>[].obs;

  // (optional legacy)
  final RxList<FlSpot> graphPoints = <FlSpot>[].obs;

  // ---------------- Lifecycle ----------------
  @override
  void onInit() {
    super.onInit();
    loadWorks();
  }

  // ---------------- Data load (JSON asset) ----------------
  Future<void> loadWorks() async {
    // JSON: assets/data/construction_works.json
    final raw = await rootBundle.loadString(
      'assets/data/construction_work.json',
    );
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    final data = list
        .map((e) => ConstructionWorkModel.fromJson(e as Map<String, dynamic>))
        .toList();

    workList.assignAll(data);
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
    List<ConstructionWorkModel> results = List.from(workList);

    // Search across useful fields
    final q = searchText.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      results = results.where((t) {
        return t.workId.toLowerCase().contains(q) ||
            t.userId.toLowerCase().contains(q) ||
            t.title.toLowerCase().contains(q) ||
            t.message.toLowerCase().contains(q) ||
            t.location.district.toLowerCase().contains(q) ||
            t.location.block.toLowerCase().contains(q) ||
            t.location.villageWard.toLowerCase().contains(q) ||
            t.location.constituency.toLowerCase().contains(q);
      }).toList();
    }

    // Filter by status
    if (selectedFilter.value != 'All') {
      results = results.where((t) => t.status == selectedFilter.value).toList();
    }

    // Sort by date
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

    // Charts
    _rebuildChartSeries(results);
    _rebuildSingleSeries(results);
  }

  // ---------------- Chart builders (STATUS wise) ----------------
  void _rebuildChartSeries(List<ConstructionWorkModel> list) {
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
            final dt = _parseDate(t.date);
            if (dt.year == day.year &&
                dt.month == day.month &&
                dt.day == day.day) {
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
          final dt = _parseDate(t.date);
          if (dt.year == first.year && dt.month == first.month) {
            final idx = dt.day - 1;
            if (idx >= 0 && idx < days) {
              if (t.status == 'Approved') {
                a[idx]++;
              } else if (t.status == 'Pending') {
                p[idx]++;
              } else if (t.status == 'Rejected') {
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
        final labels = [
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
          final dt = _parseDate(t.date);
          if (dt.year == now.year) {
            final idx = dt.month - 1;
            if (t.status == 'Approved') {
              a[idx]++;
            } else if (t.status == 'Pending') {
              p[idx]++;
            } else if (t.status == 'Rejected') {
              r[idx]++;
            }
          }
        }

        graphLabels.assignAll(labels);
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

  // Optional total (current week)
  void _rebuildSingleSeries(List<ConstructionWorkModel> list) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: (now.weekday + 6) % 7));
    final counts = List<int>.filled(7, 0);

    for (int i = 0; i < 7; i++) {
      final day = monday.add(Duration(days: i));
      for (final t in list) {
        final dt = _parseDate(t.date);
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
      ? workList.length
      : workList.where((t) => t.status == status).length;

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

  DateTime _parseDate(String isoOrPretty) {
    // Prefer ISO (yyyy-mm-dd). If pretty string, fallback parser.
    try {
      return DateTime.parse(isoOrPretty);
    } catch (_) {}
    // try very simple "21 Sept 2025"
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
