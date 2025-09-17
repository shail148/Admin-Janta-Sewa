import "package:admin_jantasewa/components/home/custom_service_card_modern.dart";
import "package:admin_jantasewa/components/home/request_carousel_slider.dart";
import "package:admin_jantasewa/view/budgetDemand/budget_all_request_page.dart";
import "package:admin_jantasewa/view/complaintLetter/complaint_letter_allrequest_page.dart";
import "package:admin_jantasewa/view/construction/construction_all_request_page.dart";
import "package:admin_jantasewa/view/hospital/hospital_main_page.dart";
import "package:admin_jantasewa/view/invitation/invitation_all_request_page.dart";
import "package:admin_jantasewa/view/parliamentVisit/parliament_visit_allrequest_page.dart";
import "package:admin_jantasewa/view/railTicketBook/rail_ticket_confirmation.dart";
import "package:admin_jantasewa/view/recommendation/recommendation_all_request_page.dart";
import "package:admin_jantasewa/view/suggestionLetter/suggestion_allrequest_page.dart";
import "package:admin_jantasewa/widgets/custom_text.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              RequestCarousel(),
              SizedBox(height: 16.h),

              // Services
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Services',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomServiceCard(
                              text: "Train Ticket Confirmation",
                              imagePath: "assets/icons/railticket.png",
                              onTap: () => Get.to(() => RailTicketConfirmationPage()),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: CustomServiceCard(
                              text: "Hospital Admission",
                              imagePath: "assets/icons/hospitalservice.png",
                              onTap: () => Get.to(() => HospitalMainPage()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Department
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Department',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomServiceCard(
                              text: "Budget Demand",
                              imagePath: "assets/icons/budget.png",
                              onTap: () => Get.to(() => BudgetAllRequestPage()),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: CustomServiceCard(
                              text: "Construction Work",
                              imagePath: "assets/icons/construction.jpg",
                              onTap: () => Get.to(() => ConstructionAllRequestPage()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Letters
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Letters',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomServiceCard(
                              height: 300.h,
                              text: "Recommendation Letter",
                              imagePath: "assets/icons/letter.jpg",
                              onTap: () => Get.to(() => RecommendationAllRequestPage()),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: CustomServiceCard(
                                    text: "Complaint Letter",
                                    imagePath: "assets/icons/complainletter.jpg",
                                    onTap: () => Get.to(() => ComplaintLetterAllRequestPage()),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Expanded(
                                  child: CustomServiceCard(
                                    text: "Suggestion Letter",
                                    imagePath: "assets/icons/suggestionletter.jpg",
                                    onTap: () => Get.to(() => SuggestionLetterAllRequestPage()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Requests
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: 'Requests',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomServiceCard(
                              text: "Parliament Visit",
                              imagePath: "assets/icons/parliament.png",
                              imageBoxFactor: 0.5,
                              onTap: () => Get.to(() => ParliamentVisitAllrequestPage()),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: CustomServiceCard(
                              text: "Invitation",
                              imagePath: "assets/icons/invitation.jpg",
                              onTap: () => Get.to(() => InvitationAllRequestPage()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}




/* import "package:admin_jantasewa/components/home/custom_service_card_modern.dart";
import "package:admin_jantasewa/components/home/request_carousel_slider.dart";
import "package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart";
import "package:admin_jantasewa/view/budgetDemand/budget_all_request_page.dart";
import "package:admin_jantasewa/view/complaintLetter/complaint_letter_allrequest_page.dart";
import "package:admin_jantasewa/view/construction/construction_all_request_page.dart";
import "package:admin_jantasewa/view/hospital/hospital_main_page.dart";
import "package:admin_jantasewa/view/invitation/invitation_all_request_page.dart";
import "package:admin_jantasewa/view/parliamentVisit/parliament_visit_allrequest_page.dart";
import "package:admin_jantasewa/view/railTicketBook/rail_ticket_confirmation.dart";
import "package:admin_jantasewa/view/recommendation/recommendation_all_request_page.dart";
import "package:admin_jantasewa/view/suggestionLetter/suggestion_allrequest_page.dart";
import "package:admin_jantasewa/widgets/custom_text.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  // static const approved = Color(0xFF16A34A);
  // static const pending = Color(0xFFF59E0B);
  // static const rejected = Color(0xFFDC2626);
  final RailTicketController c = Get.put(
    RailTicketController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NewModernCarousel(),
              RequestCarousel(),
              const SizedBox(height: 16),

              //ApplicationOverviewChart(),
              //Chart Intergrate from the unitversal chart
              // with controller data of the rail ticket
              // Series colors (match controller statusColor mapping)
              // Obx(() {
              //   // READ Rx INSIDE and convert to plain locals
              //   final List<String> labels = List<String>.from(c.graphLabels);
              //   final List<FlSpot> appr = List<FlSpot>.from(c.approvedSpots);
              //   final List<FlSpot> pend = List<FlSpot>.from(c.pendingSpots);
              //   final List<FlSpot> rej = List<FlSpot>.from(c.rejectedSpots);
              //   final rangeVal = c.chartRange.value;

              //   return UniversalMultiLineChart(
              //     title: 'Application Overview',
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
              const SizedBox(height: 16),

              CustomTextWidget(
                text: 'Services',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomServiceCard(
                    title: "Train Ticket\nConfirmation",

                    imagePath: "assets/icons/railticket.png",
                    onTap: () {
                      Get.to(() => RailTicketConfirmationPage());
                    },
                  ),
                  CustomServiceCard(
                    title: "Hospital\nAdmission",

                    imagePath: "assets/icons/hospitalservice.png",
                    onTap: () {
                      Get.to(() => HospitalMainPage());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextWidget(
                text: 'Department',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomServiceCard(
                    title: "Budget\nDemand",

                    imagePath: "assets/icons/budget.png",
                    onTap: () {
                      Get.to(() => BudgetAllRequestPage());
                    },
                  ),
                  CustomServiceCard(
                    title: "Construction\nWork",

                    imagePath: "assets/icons/construction.jpg",
                    onTap: () {
                      Get.to(() => ConstructionAllRequestPage());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextWidget(
                text: 'Letters',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      CustomServiceCard(
                        title: "Recommendation\nLetter",
                        height: 210,
                        imagePath: "assets/icons/letter.jpg",
                        onTap: () {
                          Get.to(() => RecommendationAllRequestPage());
                        },
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      Row(
                        children: [
                          CustomServiceCard(
                            title: "Complaint\nLetter",

                            imagePath: "assets/icons/complainletter.jpg",
                            onTap: () {
                              Get.to(() => ComplaintLetterAllRequestPage());
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomServiceCard(
                            title: "Suggestion\nLetter",

                            imagePath: "assets/icons/suggestionletter.jpg",
                            onTap: () {
                              Get.to(() => SuggestionLetterAllRequestPage());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextWidget(
                text: 'Requests',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomServiceCard(
                    title: "Parliament\nVisit",

                    imagePath: "assets/icons/parliament.png",
                    onTap: () {
                      Get.to(() => ParliamentVisitAllrequestPage());
                    },
                  ),
                  CustomServiceCard(
                    title: "Invitation",

                    imagePath: "assets/icons/invitation.jpg",
                    onTap: () {
                      Get.to(() => InvitationAllRequestPage());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}



 */