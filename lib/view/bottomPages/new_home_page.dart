import 'package:admin_jantasewa/components/home/custom_service_card_modern.dart';
import 'package:admin_jantasewa/components/home/new_modern_carousel.dart';
import 'package:admin_jantasewa/components/home/request_carousel_slider.dart';
import 'package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart';
import 'package:admin_jantasewa/view/budgetDemand/budget_all_request_page.dart';
import 'package:admin_jantasewa/view/complaintLetter/complaint_letter_allrequest_page.dart';
import 'package:admin_jantasewa/view/construction/construction_all_request_page.dart';
import 'package:admin_jantasewa/view/hospital/hospital_main_page.dart';
import 'package:admin_jantasewa/view/invitation/invitation_all_request_page.dart';
import 'package:admin_jantasewa/view/parliamentVisit/parliament_visit_allrequest_page.dart';
import 'package:admin_jantasewa/view/railTicketBook/rail_ticket_confirmation.dart';
import 'package:admin_jantasewa/view/recommendation/recommendation_all_request_page.dart';
import 'package:admin_jantasewa/view/suggestionLetter/suggestion_allrequest_page.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  //final RailTicketController c = Get.put(RailTicketController(),permanent: true);

  final RailTicketController controller =
      Get.find<RailTicketController>(); // Get.put() now in app binding

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // keep RequestCarousel
              //RequestCarousel(),
              NewModernCarousel(),
              const SizedBox(height: 16),

              // Services
              CustomTextWidget(
                text: 'Services',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomServiceCard(
                    title: "Rail Ticket\nConfirmation",
                    //imagePath: "assets/icons/railticket.png",
                    imagePath: 'assets/images/train.png',

                    onTap: () {
                      Get.to(() => RailTicketConfirmationPage());
                    },
                  ),

                  CustomServiceCard(
                    title: "Hospital\nAdmission",
                    // imagePath: "assets/icons/hospitalservice.png",
                    imagePath: 'assets/images/hospital.png',
                    onTap: () {
                      Get.to(() => HospitalMainPage());
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Department
              CustomTextWidget(
                text: 'Department',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomServiceCard(
                    title: "Budget\nDemand",
                    //imagePath: "assets/icons/budget.png",
                    imagePath: 'assets/images/budget.png',
                    onTap: () {
                      Get.to(() => BudgetAllRequestPage());
                    },
                  ),

                  CustomServiceCard(
                    title: "Construction\nWork",
                    //imagePath: "assets/icons/construction.jpg",
                    imagePath: 'assets/images/construction.png',
                    onTap: () {
                      Get.to(() => ConstructionAllRequestPage());
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Letters
              CustomTextWidget(
                text: 'Letters',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomServiceCard(
                    title: "Recommendation \nLetter",
                    height: 193,
                    //imagePath: "assets/icons/letter.jpg",
                    imagePath: 'assets/images/recommendation.png',
                    onTap: () {
                      Get.to(() => RecommendationAllRequestPage());
                    },
                  ),

                  // stacked two small cards
                  Column(
                    children: [
                      CustomServiceCard(
                        title: "Complaint\nLetter",
                        //imagePath: "assets/icons/complainletter.jpg",
                        imagePath: 'assets/images/complaint.png',
                        onTap: () {
                          Get.to(() => ComplaintLetterAllRequestPage());
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomServiceCard(
                        title: "Suggestion\nLetter",
                        //imagePath: "assets/icons/suggestionletter.jpg",
                        imagePath: 'assets/images/suggestion.png',
                        onTap: () {
                          Get.to(() => SuggestionLetterAllRequestPage());
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Requests
              CustomTextWidget(
                text: 'Requests',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomServiceCard(
                    title: "Parliament\nVisit",
                    //imagePath: "assets/icons/parliament.png",
                    imagePath: 'assets/images/parliament.png',
                    imageBoxFactor: 0.65,
                    onTap: () {
                      Get.to(() => ParliamentVisitAllrequestPage());
                    },
                  ),

                  CustomServiceCard(
                    title: "Invitation",
                    //imagePath: "assets/icons/invitation.jpg",
                    imagePath: 'assets/images/invitation.png',
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