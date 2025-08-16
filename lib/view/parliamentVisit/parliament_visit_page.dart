import 'package:admin_jantasewa/controllers/parliamentVisit/parliament_visit_controller.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Move controller initialization outside the widget to avoid re-creating it
final ParliamentVisitController controller = Get.put(
  ParliamentVisitController(),
  permanent: true,
);

class ParliamentVisitPage extends StatelessWidget {
  const ParliamentVisitPage({super.key});
  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  int getStatusCount(String status) {
    if (status == "All") {
      return controller.visitList.length;
    }
    return controller.visitList.where((v) => v.status == status).length;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Janta Sewa',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 80,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  buildFilterButton("All"),
                  const SizedBox(width: 8),
                  buildFilterButton("Pending"),
                  const SizedBox(width: 8),
                  buildFilterButton("Approved"),
                  const SizedBox(width: 8),
                  buildFilterButton("Rejected"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    final visit = controller.filteredList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.galleryBdColors),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visit.visitId,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 20),
                              const SizedBox(width: 8),
                              Text(visit.visitorName),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_city, size: 20),
                              const SizedBox(width: 8),
                              Text('Constituency: ${visit.constituency}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.account_circle, size: 20),
                              const SizedBox(width: 8),
                              Text('MP: ${visit.mpName}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.date_range, size: 20),
                              const SizedBox(width: 8),
                              Text('Visit Date: ${visit.visitDate}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20),
                              const SizedBox(width: 8),
                              Text('Request Date: ${visit.requestDate}'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text('Status :'),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(
                                    visit.status,
                                  ).withValues(alpha: 0.2),
                                  border: Border.all(
                                    color: getStatusColor(visit.status),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CustomTextWidget(
                                  text: visit.status,
                                  color: getStatusColor(visit.status),
                                  fontsize: 10,
                                ),
                              ),
                              const Spacer(),
                              CustomButton(
                                text: 'view>>',
                                textSize: 10,
                                onPressed: () {
                                  // Handle view action
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterButton(String status) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == status;
      final count = getStatusCount(status);
      return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.btnBgColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: () {
            controller.filterVisits(status);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
