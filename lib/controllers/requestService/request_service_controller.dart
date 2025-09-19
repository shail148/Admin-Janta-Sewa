import 'package:get/get.dart';
import 'package:admin_jantasewa/data/requested_service_data.dart';

class RequestServicesController extends GetxController {
  final RxList<Map<String, dynamic>> allServices = <Map<String, dynamic>>[].obs;
  final RxString searchQuery = ''.obs;
  final RxSet<int> expandedIndexes = <int>{}.obs;

  final RxString sortBy = 'date'.obs;
  final RxString statusFilter = ''.obs;

  @override
  void onInit() {
    super.onInit();
    //  Load the static JSON data here
    allServices.assignAll(requestedServices);
  }

  List<Map<String, dynamic>> get filtered {
    final filteredList = allServices.where((item) {
      final matchesSearch = item['title']
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase());
      final matchesStatus = statusFilter.value.isEmpty ||
          item['status'] == statusFilter.value;
      return matchesSearch && matchesStatus;
    }).toList();

    switch (sortBy.value) {
      case 'status':
        filteredList.sort((a, b) =>
            a['status'].toString().compareTo(b['status'].toString()));
        break;
      case 'title':
        filteredList.sort((a, b) => a['title']
            .toString()
            .toLowerCase()
            .compareTo(b['title'].toString().toLowerCase()));
        break;
      case 'date':
      default:
        filteredList.sort(
            (a, b) => b['date'].toString().compareTo(a['date'].toString()));
    }
    return filteredList;
  }

  void toggleExpand(int index) {
    expandedIndexes.contains(index)
        ? expandedIndexes.remove(index)
        : expandedIndexes.add(index);
  }

  void updateSearch(String value) => searchQuery.value = value;
  void setSort(String choice) => sortBy.value = choice;
  void setStatusFilter(String status) =>
      statusFilter.value = status == 'All' ? '' : status;
}


/* import 'package:get/get.dart';
import 'package:admin_jantasewa/data/requested_service_data.dart';

class RequestServicesController extends GetxController {
  var sortOption = 'Date'.obs;
  var filterOption = 'All'.obs;

  // original list
  final allServices = requestedServices.obs;

  // computed list that applies filter & sort
  List<Map<String, dynamic>> get displayedServices {
    var list = List<Map<String, dynamic>>.from(allServices);

    // Filter
    if (filterOption.value != 'All') {
      list = list
          .where((e) => e['status'] == filterOption.value)
          .toList();
    }

    // Sort
    switch (sortOption.value) {
      case 'Title':
        list.sort((a, b) => a['title'].compareTo(b['title']));
        break;
      case 'Status':
        list.sort((a, b) => a['status'].compareTo(b['status']));
        break;
      default: // Date
        list.sort((a, b) => b['date'].compareTo(a['date']));
    }
    return list;
  }

  void setSort(String value) => sortOption.value = value;
  void setFilter(String value) => filterOption.value = value;
}
 */