// lib/controllers/railTicket/rail_ticket_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:admin_jantasewa/models/ticket/ticket_model.dart';

/// W/M/Y chart range (Universal chart ke liye)
enum ChartRange { week, month, year }

class RailTicketController extends GetxController {
  // ------------ Source / UI lists ------------
  final RxList<TicketModel> ticketList = <TicketModel>[].obs;
  final RxList<TicketModel> filteredList = <TicketModel>[].obs;

  // ------------ Filters / Search / Sort ------------
  final RxString selectedFilter =
      'All'.obs; // All | Approved | Pending | Rejected
  final RxString selectedSort = 'Newest'.obs; // Newest | Oldest
  final RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // ------------ Chart state (multi-series) ------------
  final Rx<ChartRange> chartRange = ChartRange.week.obs;
  final RxList<String> graphLabels = <String>[].obs; // x-axis labels
  final RxList<FlSpot> approvedSpots = <FlSpot>[].obs; // green
  final RxList<FlSpot> pendingSpots = <FlSpot>[].obs; // amber
  final RxList<FlSpot> rejectedSpots = <FlSpot>[].obs; // red

  // (optional) single-series legacy usage
  final RxList<FlSpot> graphPoints = <FlSpot>[].obs;

  // ------------ Lifecycle ------------
  @override
  void onInit() {
    super.onInit();
    loadTickets(); // json se load + initial apply()
  }

  // ------------ Data load (JSON asset) ------------
  Future<void> loadTickets() async {
    final raw = await rootBundle.loadString(
      'assets/data/rail_tickets_500.json',
    );
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    final data = list
        .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
        .toList();

    ticketList.assignAll(data);
    apply(); // filter + chart build
  }

  // ------------ Public API (UI actions) ------------
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
    _rebuildChartSeries(filteredList); // same filtered data par chart rebuild
  }

  // ------------ Pipeline (search → filter → sort → chart) ------------
  void apply() {
    List<TicketModel> results = List.from(ticketList);

    // search
    final q = searchText.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      results = results.where((t) {
        return t.ticketId.toLowerCase().contains(q) ||
            t.userId.toLowerCase().contains(q) ||
            t.trainName.toLowerCase().contains(q) ||
            t.trainNumber.toLowerCase().contains(q) ||
            t.pnrNumber.toLowerCase().contains(q) ||
            t.reason.toLowerCase().contains(q) ||
            t.from.toLowerCase().contains(q) ||
            t.to.toLowerCase().contains(q);
      }).toList();
    }

    // filter
    if (selectedFilter.value != 'All') {
      results = results.where((t) => t.status == selectedFilter.value).toList();
    }

    // sort
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

    // charts
    _rebuildChartSeries(results); // multi-series (W/M/Y)
    _rebuildSingleSeries(results); // optional legacy single series
  }

  // ------------ Chart builders ------------
  void _rebuildChartSeries(List<TicketModel> list) {
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

  // Optional: single series (total tickets) if kisi purane widget me chahiye
  void _rebuildSingleSeries(List<TicketModel> list) {
    // total per day for current week
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

  // ------------ Helpers ------------
  int statusBadgeCount(String status) => status == 'All'
      ? ticketList.length
      : ticketList.where((t) => t.status == status).length;

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
