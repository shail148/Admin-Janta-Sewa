import 'package:admin_jantasewa/controllers/hospital/hospital_admission_controller.dart';
import 'package:admin_jantasewa/shared/user_detail_bottom_sheet/user_detail_bottom_sheet.dart';
import 'package:admin_jantasewa/shared/user_detail_bottom_sheet/user_detail_bottomsheet_controller.dart';
import 'package:admin_jantasewa/view/hospital/hospital_admission_details_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_bottom_sheet.dart';
import 'package:admin_jantasewa/widgets/custom_info_card.dart';
import 'package:admin_jantasewa/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalMainPage extends StatefulWidget {
  const HospitalMainPage({super.key});

  @override
  State<HospitalMainPage> createState() => _HospitalMainPageState();
}

class _HospitalMainPageState extends State<HospitalMainPage> {
  final HospitalAdmissionController c = Get.put(
    HospitalAdmissionController(),
    permanent: true,
  );
  // static const approved = Color(0xFF16A34A);
  // static const pending = Color(0xFFF59E0B);
  // static const rejected = Color(0xFFDC2626);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Hospital Admission',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // ---------------- Search ----------------
            CustomSearchBar(
              controller: c.searchController,
              hint: 'Search....',
              onChanged: c.setSearch, // live search
              onClear: c.clearSearch, // resets
              // If your CustomSearchBar does not support onSearchPressed, remove the next line:
              onSearchPressed: () => c.setSearch(c.searchController.text),
            ),

            const SizedBox(height: 12),

            // ---------------- Chart (Obx-scoped locals to avoid GetX warning) ----------------
            // Obx(() {
            //   // READ Rx INSIDE and convert to plain locals
            //   final List<String> labels = List<String>.from(c.graphLabels);
            //   final List<FlSpot> appr = List<FlSpot>.from(c.approvedSpots);
            //   final List<FlSpot> pend = List<FlSpot>.from(c.pendingSpots);
            //   final List<FlSpot> rej = List<FlSpot>.from(c.rejectedSpots);
            //   final rangeVal = c.chartRange.value;

            //   return UniversalMultiLineChart(
            //     title: 'Rail Ticket Confirmation',
            //     xLabels: labels,
            //     series: [
            //       ChartSeries(name: 'Approved', spots: appr, color: approved),
            //       ChartSeries(name: 'Pending', spots: pend, color: pending),
            //       ChartSeries(name: 'Rejected', spots: rej, color: rejected),
            //     ],
            //     showLegend: true,
            //     showRangeToggle: true,
            //     range: rangeVal,
            //     onRangeChanged: (r) => c.setChartRange(r),
            //     height: 180,
            //   );
            // }),
            const SizedBox(height: 8),

            // ---------------- Tickets List ----------------
            Expanded(
              child: Obx(() {
                final list = c.filteredList; // Rx read inside Obx
                if (list.isEmpty) {
                  return const Center(child: Text('No tickets found'));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final hostpital = list[i];
                    return CustomInfoCard(
                      title: hostpital.requestId,
                      rows: [
                        /* InfoRowData(
                          icon: Icons.perm_identity_outlined,
                          text: 'ID : ${hostpital.userId}',
                        ), */

                        InfoRowData(
                          icon: Icons.perm_identity_outlined,
                          text: 'ID : ${hostpital.userId}',
                          onTap: () async {
                          final controller = Get.put(UserDetailBottomSheetController());
                          await controller.loadUserData();
                          if (!context.mounted) return; 
                          showModalBottomSheet(
                          context: context,
                          builder: (context) => UserDetailBottomSheet(userId: hostpital.userId),
                         );
                       },

                 ), 
                        InfoRowData(
                          icon: Icons.calendar_today,
                          text: 'Requested Date : ${hostpital.requestDate}',
                        ),
                        InfoRowData(icon: Icons.chat, text: hostpital.reason),
                      ],
                      description: hostpital.reason,
                      status: hostpital.status,
                      statusColor: c.statusColor(hostpital.status),
                      buttonText: 'View',
                      onButtonTap: () => Get.to(
                        () => HospitalAdmissionDetailsPage(),
                        arguments: hostpital,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),

      // ---------------- Bottom bar: Sort | Filter ----------------
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => openOptionsSheet(context, 'Sort By', [
                    BottomSheetOption('Newest', () => c.setSort('Newest')),
                    BottomSheetOption('Oldest', () => c.setSort('Oldest')),
                  ]),
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Sort By'),
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => openOptionsSheet(context, 'Filter', [
                    BottomSheetOption(
                      'All Requests',
                      () => c.setStatusFilter('All'),
                    ),
                    BottomSheetOption(
                      'Pending',
                      () => c.setStatusFilter('Pending'),
                    ),
                    BottomSheetOption(
                      'Approved',
                      () => c.setStatusFilter('Approved'),
                    ),
                    BottomSheetOption(
                      'Rejected',
                      () => c.setStatusFilter('Rejected'),
                    ),
                  ]),
                  icon: const Icon(Icons.tune),
                  label: const Text('Filter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
