import 'package:admin_jantasewa/controllers/complaintLetter/complaint_letter_controller.dart';
import 'package:admin_jantasewa/view/complaintLetter/complaint_letter_details_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_info_card.dart';
import 'package:admin_jantasewa/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintLetterAllRequestPage extends StatefulWidget {
  const ComplaintLetterAllRequestPage({super.key});

  @override
  State<ComplaintLetterAllRequestPage> createState() =>
      _ComplaintLetterAllRequestPageState();
}

class _ComplaintLetterAllRequestPageState
    extends State<ComplaintLetterAllRequestPage> {
  final c = Get.put(ComplaintLetterController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Complaint Letters',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomSearchBar(
              controller: c.searchController,
              hint: 'Search....',
              onChanged: c.setSearch,
              onClear: c.clearSearch,
              onSearchPressed: () => c.setSearch(c.searchController.text),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                final list = c.filteredList;
                if (list.isEmpty) {
                  return const Center(child: Text('No complaints found'));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final complaint = list[i];
                    return CustomInfoCard(
                      title: complaint.complaintId,
                      rows: [
                        InfoRowData(
                          icon: Icons.perm_identity_outlined,
                          text: 'ID : ${complaint.userId}',
                        ),
                        InfoRowData(
                          icon: Icons.calendar_today,
                          text: 'Requested Date : ${complaint.date}',
                        ),
                        InfoRowData(icon: Icons.chat, text: complaint.message),
                      ],
                      description: complaint.title,
                      status: complaint.status,
                      statusColor: c.statusColor(complaint.status),
                      buttonText: 'View',
                      onButtonTap: () => Get.to(
                        () => ComplaintLetterDetailsPage(),
                        arguments: complaint,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
