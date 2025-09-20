import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/components/requestedServices/request_services_list_screen.dart';
import 'package:admin_jantasewa/controllers/requestService/request_service_controller.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available and loads JSON data, controller in app binding under binding folder
    final RequestServicesController controller = Get.find<RequestServicesController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomTopAppBar(
        title: 'Requests History',
        leftIcon: const Icon(Icons.arrow_back_ios),
        //onLeftTap: Get.back,
        //for proper handling of back button in web ,chrome 
        onLeftTap: () {
       if (Get.previousRoute.isNotEmpty) {
        Get.back();
      } else {
        Get.toNamed('/dashboard'); // fallback route
      }
       }
        ),

      // Show the list from GetX controller
      body: RequestServicesDataListScreen(),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomButton(
              'Sort By',
              Icons.sort,
              () async {
                final choice = await _showSortSheet();
                if (choice != null) controller.setSort(choice.toLowerCase());
              },
            ),
            _bottomButton(
              'Filter',
              Icons.filter_list,
              () async {
                final choice = await _showFilterSheet();
                if (choice != null) controller.setStatusFilter(choice);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(String label, IconData icon, VoidCallback onTap) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: AppColors.primary),
      label: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: AppColors.primary)),
    );
  }

  Future<String?> _showSortSheet() {
    return Get.bottomSheet<String>(
      _optionSheet(['Date', 'Status', 'Title']),
      backgroundColor: AppColors.white,
    );
  }

  Future<String?> _showFilterSheet() {
    return Get.bottomSheet<String>(
      _optionSheet(['All', 'Approved', 'Rejected', 'Pending', 'In Process']),
      backgroundColor: AppColors.white,
    );
  }

  Widget _optionSheet(List<String> options) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options
          .map((e) => ListTile(
                title: Text(e),
                onTap: () => Get.back(result: e),
              ))
          .toList(),
    );
  }
}


/* import 'package:admin_jantasewa/components/requestedServices/request_services.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Requestpage extends StatefulWidget {
  const Requestpage({super.key});

  @override
  State<Requestpage> createState() => _RequestpageState();
}

class _RequestpageState extends State<Requestpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'History',
          leftIcon: const Icon(Icons.arrow_back_ios),
          onLeftTap: Get.back,
      ),
      body: const RequestServicesData(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomButton('Sort By', Icons.sort, () {
              // TODO: open your sort dialog
            }),
            _buildBottomButton('Filter', Icons.filter_list, () {
              // TODO: open your filter dialog
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(String label, IconData icon, VoidCallback onTap) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.deepPurple),
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}


 */