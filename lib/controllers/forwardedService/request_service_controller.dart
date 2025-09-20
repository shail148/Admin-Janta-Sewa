import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:admin_jantasewa/data/requested_service_data.dart';

class RequestServicesController extends GetxController {
  /// Observables
  final RxList<Map<String, dynamic>> allServices = <Map<String, dynamic>>[].obs;
  final RxString searchQuery = ''.obs;
  final RxSet<int> expandedIndexes = <int>{}.obs;

  final RxString sortBy = 'date'.obs;
  final RxString statusFilter = ''.obs;

  /// Keep a controller for search text field (so it doesn’t rebuild every frame)
  final TextEditingController searchController = TextEditingController();

  /// Loading state (useful if later you fetch from API)
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadServices();
  }

  /// Load data (static for now, can be API later)
  void loadServices() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300)); // mimic delay
    allServices.assignAll(requestedServices);
    isLoading.value = false;
  }

  /// Filtered + sorted list
  List<Map<String, dynamic>> get filtered {
    final filteredList = allServices.where((item) {
      final title = (item['title'] ?? '').toString().toLowerCase();
      final status = (item['status'] ?? '').toString();
      final query = searchQuery.value.toLowerCase();

      final matchesSearch = title.contains(query);
      final matchesStatus =
          statusFilter.value.isEmpty || status == statusFilter.value;

      return matchesSearch && matchesStatus;
    }).toList();

    switch (sortBy.value) {
      case 'status':
        filteredList.sort(
          (a, b) => (a['status'] ?? '').toString().compareTo(
            (b['status'] ?? '').toString(),
          ),
        );
        break;
      case 'title':
        filteredList.sort(
          (a, b) => (a['title'] ?? '').toString().toLowerCase().compareTo(
            (b['title'] ?? '').toString().toLowerCase(),
          ),
        );
        break;
      case 'date':
      default:
        // NOTE: You might want to parse as DateTime if "date" is real
        filteredList.sort(
          (a, b) => (b['date'] ?? '').toString().compareTo(
            (a['date'] ?? '').toString(),
          ),
        );
    }
    return filteredList;
  }

  /// Expand/Collapse service card
  void toggleExpand(int index) {
    if (expandedIndexes.contains(index)) {
      expandedIndexes.remove(index);
    } else {
      expandedIndexes.add(index);
    }
  }

  /// Search & Filters
  void updateSearch(String value) => searchQuery.value = value;

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  void setSort(String choice) => sortBy.value = choice;

  void setStatusFilter(String status) =>
      statusFilter.value = status == 'All' ? '' : status;

  // /// Refresh data (pull-to-refresh support)
  // Future<void> refreshServices() async {
  //   // ignore: await_only_futures
  //   await loadServices();
  // }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
