import 'package:admin_jantasewa/controllers/parliamentVisit/parliament_visit_controller.dart';
import 'package:admin_jantasewa/shared/user_detail_bottom_sheet/user_detail_bottom_sheet.dart';
import 'package:admin_jantasewa/shared/user_detail_bottom_sheet/user_detail_bottomsheet_controller.dart';
import 'package:admin_jantasewa/view/parliamentVisit/parliament_details_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_bottom_sheet.dart';
import 'package:admin_jantasewa/widgets/custom_info_card.dart';
import 'package:admin_jantasewa/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParliamentVisitAllrequestPage extends StatefulWidget {
  const ParliamentVisitAllrequestPage({super.key});

  @override
  State<ParliamentVisitAllrequestPage> createState() =>
      _ParliamentVisitAllrequestPageState();
}

class _ParliamentVisitAllrequestPageState
    extends State<ParliamentVisitAllrequestPage> {
  final ParliamentVisitController c = Get.put(
    ParliamentVisitController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Parliament Visit',
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
                    final visit = list[i];
                    return CustomInfoCard(
                      title: visit.parliamentVisitId,
                      rows: [
                        /* InfoRowData(
                          icon: Icons.perm_identity_outlined,
                          text: 'ID : ${visit.userId}',
                        ), */
                         InfoRowData(
                          icon: Icons.perm_identity_outlined,
                          text: 'ID : ${visit.userId}',
                          onTap: () async {
                          final controller = Get.put(UserDetailBottomSheetController());
                          await controller.loadUserData();
                          if (!context.mounted) return; 
                          showModalBottomSheet(
                          context: context,
                          builder: (context) => UserDetailBottomSheet(userId: visit.userId),
                         );
                       },

                 ),
                        InfoRowData(
                          icon: Icons.calendar_today,
                          text: 'Requested Date : ${visit.requestDate}',
                        ),
                        InfoRowData(icon: Icons.chat, text: visit.reason),
                      ],
                      description: visit.reason,
                      status: visit.status,
                      statusColor: c.statusColor(visit.status),
                      buttonText: 'View',
                      onButtonTap: () => Get.to(
                        () => ParliamentDetailsPage(),
                        arguments: visit,
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
