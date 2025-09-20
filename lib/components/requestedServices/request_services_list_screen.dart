import 'package:admin_jantasewa/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/requestService/request_service_controller.dart';
import 'package:admin_jantasewa/widgets/custom_search_bar.dart';

/* class RequestServicesDataListScreen extends StatelessWidget {
  RequestServicesDataListScreen({super.key});

  final RequestServicesController controller =Get.find<RequestServicesController>();

       

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          CustomSearchBar(
            controller: TextEditingController(
              text: controller.searchQuery.value,
            ),
            hint: 'Search...',
            onChanged: controller.updateSearch,
            onClear: () => controller.updateSearch(''),
            onSearchPressed: () {
              Get.snackbar('Search', 'Searching..');
              //will implement search button  later with real logic
            },
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < controller.filtered.length; i++)
            _buildServiceCard(controller.filtered[i], i),
        ],
      ),
    );
  } */

 class RequestServicesDataListScreen extends StatelessWidget {
  RequestServicesDataListScreen({super.key});

  final RequestServicesController controller =
      Get.find<RequestServicesController>();

  // keep a single TextEditingController
  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      searchCtrl.text = controller.searchQuery.value;
      searchCtrl.selection = TextSelection.collapsed(
          offset: searchCtrl.text.length); // keep cursor at end if needed

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          CustomSearchBar(
            controller: searchCtrl,
            hint: 'Search...',
            onChanged: controller.updateSearch,
            onClear: () {
              searchCtrl.clear();
              controller.updateSearch('');
            },
            onSearchPressed: () => Get.snackbar('Search', 'Searching..'),
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < controller.filtered.length; i++)
            _buildServiceCard(controller.filtered[i], i),
        ],
      );
    });
  }


  Widget _buildServiceCard(Map<String, dynamic> item, int index) {
    final bool isExpanded = controller.expandedIndexes.contains(index);

    return GestureDetector(
      onTap: () => controller.toggleExpand(index),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: AssetImage(item['image']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['id'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusChip(item['status']),
                    const SizedBox(height: 4),
                    Text(
                      item['date'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _messageBgColor(item['status']), // light background behind msg text
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['msg'],
                  style: TextStyle(
                    fontSize: 14,
                    color: _messageColor(item['status']),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color txt;
    switch (status) {
      case 'Approved':
        bg = Colors.green.shade100;
        txt = Colors.green.shade800;
        break;
      case 'Rejected':
        bg = Colors.red.shade100;
        txt = Colors.red.shade800;
        break;
      case 'Pending':
        bg = Colors.orange.shade100;
        txt = Colors.orange.shade800;
        break;
      case 'In Process':
        bg = Colors.blue.shade100;
        txt = Colors.blue.shade800;
        break;
      default:
        bg = Colors.grey.shade300;
        txt = Colors.black87;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: txt),
      ),
    );
  }

  Color _messageColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green.shade700;
      case 'Rejected':
        return Colors.red.shade700;
      case 'Pending':
        return Colors.orange.shade700;
      case 'In Process':
        return Colors.blue.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  Color _messageBgColor(String status) {
  switch (status) {
    case 'Approved':
      return Colors.green.shade50;
    case 'Rejected':
      return Colors.red.shade50;
    case 'Pending':
      return Colors.orange.shade50;
    case 'In Process':
      return Colors.blue.shade50;
    default:
      return Colors.grey.shade100;
  }
}

}


 /* import 'package:flutter/material.dart';
import 'package:admin_jantasewa/data/requested_service_data.dart';
import 'package:admin_jantasewa/widgets/custom_search_bar.dart';

class RequestServicesData extends StatefulWidget {

  const RequestServicesData({super.key});

  @override
  State<RequestServicesData> createState() => _RequestServicesDataState();
}

class _RequestServicesDataState extends State<RequestServicesData> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  final Set<int> expandedIndexes = {};

  @override
  Widget build(BuildContext context) {
    final filtered = requestedServices
        .where((item) =>
            item['title'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        CustomSearchBar(
          controller: searchController,
          hint: 'Search...',
          onChanged: _onSearchChanged,
          onClear: _clearSearch,
          onSearchPressed: _search,
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < filtered.length; i++)
          _buildServiceCard(filtered[i], i),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> item, int index) {
    final isExpanded = expandedIndexes.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isExpanded) {
            expandedIndexes.remove(index);
          } else {
            expandedIndexes.add(index);
          }
        });
      },
      child: Container(
        // full-width white container with grey border
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular avatar for image
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: AssetImage(item['image']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(item['id'],
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusChip(item['status']),
                    const SizedBox(height: 4),
                    Text(item['date'],
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 8),
              Text(
                item['msg'],
                style: TextStyle(
                  fontSize: 12,
                  color: _messageColor(item['status']),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color txt;
    switch (status) {
      case 'Approved':
        bg = Colors.green.shade100;
        txt = Colors.green.shade800;
        break;
      case 'Rejected':
        bg = Colors.red.shade100;
        txt = Colors.red.shade800;
        break;
      case 'Pending':
        bg = Colors.orange.shade100;
        txt = Colors.orange.shade800;
        break;
      case 'In Process':
        bg = Colors.blue.shade100;
        txt = Colors.blue.shade800;
        break;
      default:
        bg = Colors.grey.shade300;
        txt = Colors.black87;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(status,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: txt)),
    );
  }

  Color _messageColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green.shade700;
      case 'Rejected':
        return Colors.red.shade700;
      case 'Pending':
        return Colors.orange.shade700;
      case 'In Process':
        return Colors.blue.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  void _onSearchChanged(String value) {
    setState(() => searchQuery = value);
  }

  void _clearSearch() {
    setState(() {
      searchQuery = '';
      searchController.clear();
    });
  }

  void _search() {
    setState(() => searchQuery = searchController.text);
  }
}
 

 */