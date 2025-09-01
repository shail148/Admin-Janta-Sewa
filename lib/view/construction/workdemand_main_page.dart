import 'package:admin_jantasewa/controllers/construction/workdemand_controller.dart';
import 'package:admin_jantasewa/view/construction/construction_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:admin_jantasewa/widgets/view_details_button.dart';

import 'package:admin_jantasewa/models/construction_model/workdemand_model.dart';
// import 'package:admin_jantasewa/view/construction/workdemand_details_page.dart';

class WorkDemandMainPage extends StatefulWidget {
  const WorkDemandMainPage({super.key});

  @override
  State<WorkDemandMainPage> createState() => _WorkDemandMainPageState();
}

class _WorkDemandMainPageState extends State<WorkDemandMainPage> {
  /// Put controller once for this page
  final WorkDemandController controller = Get.put(WorkDemandController());

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
    final list = controller.demands;
    if (status == "All") return list.length;
    return list.where((d) => d.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Janta Sewa',
        leftIcon: const Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          /// Filter chips (All/Pending/Approved/Rejected)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 72, // keep parent & child heights harmonious
              child: Obx(() {
                // Rebuild when selectedFilter or demands change
                final _ = controller.demands.length; // touch to track changes
                return ListView(
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
                );
              }),
            ),
          ),

          const SizedBox(height: 8),

          /// List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.filteredList.isEmpty) {
                return const Center(child: Text("No work demands found."));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: controller.filteredList.length,
                  itemBuilder: (context, index) {
                    final WorkDemandModel workitems =
                        controller.filteredList[index];

                    return SideCustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // WorkId tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC9D8F8),
                              border: Border.all(color: AppColors.btnBgColor),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              workitems.workId,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Demanded person
                          Row(
                            children: [
                              const Icon(Icons.person_outline, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  workitems.demandedPerson,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),

                          // Work Name
                          Row(
                            children: [
                              const Icon(Icons.build_outlined, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  workitems.workName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          // Requested date
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Requested Date: ${workitems.requestedDate}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Footer: Status chip + View button
                          Row(
                            children: [
                              const Icon(Icons.schedule_outlined, size: 18),
                              const SizedBox(width: 6),
                              const Text('Status: '),
                              const SizedBox(width: 6),
                              _StatusChip(
                                status: workitems.status,
                                color: getStatusColor(workitems.status),
                              ),
                              const Spacer(),
                              ViewDetailsButton(
                                onTap: () {
                                  Get.to(
                                    () => const ConstructionDetailsPage(),
                                    arguments: workitems,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ---- Helpers ---------------------------------------------------

  Widget buildFilterButton(String status) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == status;
      final count = getStatusCount(status);

      return SizedBox(
        height: 64, // <= parent height (72)
        width: 96,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.btnBgColor
                : Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
          onPressed: () => controller.filterDemands(status),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

// If your model doesn’t yet include a date, show placeholder.
// Add a `requestedDate` field in WorkDemandModel to render real data.
// String _requestedDate(WorkDemandModel item) {
//   // Example if you later add: item.requestedDate (DateTime?)
//   // return item.requestedDate != null ? DateFormat('dd MMM yyyy').format(item.requestedDate!) : '—';
//   return '—';
// }

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.color});
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
