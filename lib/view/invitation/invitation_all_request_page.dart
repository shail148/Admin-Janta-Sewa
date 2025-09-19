import 'package:admin_jantasewa/controllers/invitation/invitation_controller.dart';
import 'package:admin_jantasewa/view/invitation/invitation_details_page.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_bottom_sheet.dart';
import 'package:admin_jantasewa/widgets/custom_info_card.dart';
import 'package:admin_jantasewa/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitationAllRequestPage extends StatefulWidget {
  const InvitationAllRequestPage({super.key});

  @override
  State<InvitationAllRequestPage> createState() =>
      _InvitationAllRequestPageState();
}

class _InvitationAllRequestPageState extends State<InvitationAllRequestPage> {
  final c = Get.put(InvitationController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Janta Sewa',
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
                    final invitation = list[i];
                    return CustomInfoCard(
                      title: invitation.invitationId,
                      rows: [
                        InfoRowData(
                          icon: Icons.perm_identity_outlined,
                          text: 'ID : ${invitation.userId}',
                        ),
                        InfoRowData(
                          icon: Icons.calendar_today,
                          text: 'Requested Date : ${invitation.requestDate}',
                        ),

                        InfoRowData(icon: Icons.chat, text: invitation.reason),
                      ],
                      description: invitation.reason,
                      status: invitation.status,
                      statusColor: c.statusColor(invitation.status),
                      buttonText: 'View',
                      onButtonTap: () => Get.to(
                        () => InvitationDetailsPage(),
                        arguments: invitation,
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
