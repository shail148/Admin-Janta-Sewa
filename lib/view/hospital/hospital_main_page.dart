import 'package:admin_jantasewa/controllers/hospital/hospital_admission_controller.dart';
import 'package:admin_jantasewa/models/hospital/hospital_admission_model.dart';
import 'package:admin_jantasewa/view/hospital/hospital_admission_details_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/side_card_design.dart';
import 'package:admin_jantasewa/widgets/view_details_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalMainPage extends StatefulWidget {
  const HospitalMainPage({super.key});

  @override
  State<HospitalMainPage> createState() => _HospitalMainPageState();
}

class _HospitalMainPageState extends State<HospitalMainPage> {
  final HospitalAdmissionController controller = Get.put(
    HospitalAdmissionController(),
  );

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

  // Count admissions by status
  int getStatusCount(String status) {
    if (status == "All") {
      return controller.admissionList.length;
    }
    return controller.admissionList.where((a) => a.status == status).length;
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
                    final HospitalAdmissionModel admission =
                        controller.filteredList[index];

                    return SideCustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFFC9D8F8),
                              border: Border.all(color: AppColors.btnBgColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              admission.requestId,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 20),
                              const SizedBox(width: 8),
                              Text(admission.patientName),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.local_hospital, size: 20),
                              const SizedBox(width: 8),
                              Expanded(child: Text(admission.hospitalName)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.medical_information, size: 20),
                              const SizedBox(width: 8),
                              Text(admission.diseaseName),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.date_range, size: 20),
                              const SizedBox(width: 8),
                              Text('Requested Date : ${admission.requestDate}'),
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
                                    admission.status,
                                  ).withValues(alpha: 0.2),
                                  // border: Border.all(
                                  //   color: getStatusColor(admission.status),
                                  // ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CustomTextWidget(
                                  text: admission.status,
                                  color: getStatusColor(admission.status),
                                  fontsize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              ViewDetailsButton(
                                onTap: () {
                                  Get.to(
                                    () => HospitalAdmissionDetailsPage(),
                                    arguments: admission,
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
            controller.filterAdmissions(status);
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
