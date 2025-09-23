import 'package:admin_jantasewa/components/home/custom_service_card_modern.dart';
import 'package:admin_jantasewa/components/home/new_modern_carousel.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  //final RailTicketController c = Get.put(RailTicketController(),permanent: true);

  final RailTicketController controller = Get.find<RailTicketController>(); // Get.put() now in app binding

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // keep RequestCarousel
              //RequestCarousel(),
              NewModernCarousel(),
               SizedBox(height: 16.h),

              // Services
              CustomTextWidget(
                text: 'Services',
                fontWeight: FontWeight.bold,
                fontsize: 14,
              ),
               SizedBox(height: 10.h),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomServiceCard(
                     width: 160.w,
                    title: "Rail Ticket\nConfirmation",
                    //imagePath: "assets/icons/railticket.png",
                    imagePath: 'assets/images/train.png',

                    onTap: () {
                      Get.to(() => RailTicketConfirmationPage());
                    },
                  ),
                 // SizedBox(width: 10),
                  SizedBox(width: 8.w),
                  CustomServiceCard(
                     width: 160.w,
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
                text: 'Departments',
                fontWeight: FontWeight.bold,
                
                fontsize: 14,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomServiceCard(
                     width: 160.w,  
                    height: 75.h,
                    title: "Budget\nDemand",
                    //imagePath: "assets/icons/budget.png",
                    imagePath: 'assets/images/budget.png',
                    onTap: () {
                      Get.to(() => BudgetAllRequestPage());
                    },
                  ),
                  SizedBox(width: 8.w),

                  CustomServiceCard(
                    width: 160.w,
                    height: 75.h,
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
                  //one large recommendation card
                  CustomServiceCard(
                    width: 160.w,
                    title: "Recommendation \nLetter",
                     height: 158.h,
                    //imagePath: "assets/icons/letter.jpg",
                    imagePath: 'assets/images/recommendation.png',
                    onTap: () {
                      Get.to(() => RecommendationAllRequestPage());
                    },
                  ),
                  SizedBox(width: 8.w),
                  //SizedBox(width: 12),

                  // stacked two small cards
                  Column(
                    children: [
                      CustomServiceCard(
                        width: 160.w,
                    height: 75.h,
                        title: "Complaint\nLetter",
                        //imagePath: "assets/icons/complainletter.jpg",
                        imagePath: 'assets/images/complaint.png',
                        onTap: () {
                          Get.to(() => ComplaintLetterAllRequestPage());
                        },
                      ),
                       SizedBox(height: 8.h),
                      CustomServiceCard(
                        width: 160.w,
                    height: 75.h,
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
                    width: 160.w,
                    height: 75.h,
                    title: "Parliament\nVisit",
                    //imagePath: "assets/icons/parliament.png",
                    imagePath: 'assets/images/parliament.png',
                    imageBoxFactor: 0.65,
                    onTap: () {
                      Get.to(() => ParliamentVisitAllrequestPage());
                    },
                  ),

                //  SizedBox(width: 12),
                  SizedBox(width: 8.w),
                  CustomServiceCard(
                    width: 160.w,
                    height: 75.h,
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




 /*
import 'package:admin_jantasewa/components/home/custom_service_card_modern.dart';
import 'package:admin_jantasewa/components/home/new_modern_carousel.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final RailTicketController controller = Get.find<RailTicketController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w), // use .w for width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RequestCarousel(), // keep if needed
              NewModernCarousel(),
              SizedBox(height: 16.h),

              /// Services
              CustomTextWidget(
                text: 'Services',
                fontWeight: FontWeight.bold,
                fontsize: 14.sp, // scale font
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  CustomServiceCard(
                    width: 160.w,
                    title: "Rail Ticket\nConfirmation",
                    imagePath: 'assets/images/train.png',
                    onTap: () => Get.to(() =>  RailTicketConfirmationPage()),
                  ),
                  SizedBox(width: 8.w),
                  CustomServiceCard(
                    width: 160.w,
                    title: "Hospital\nAdmission",
                    imagePath: 'assets/images/hospital.png',
                    onTap: () => Get.to(() => const HospitalMainPage()),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Department
              CustomTextWidget(
                text: 'Department',
                fontWeight: FontWeight.bold,
                fontsize: 14.sp,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  CustomServiceCard(
                    width: 160.w,
                    height: 75.h,
                    title: "Budget\nDemand",
                    imagePath: 'assets/images/budget.png',
                    onTap: () => Get.to(() => const BudgetAllRequestPage()),
                  ),
                  SizedBox(width: 8.w),
                  CustomServiceCard(
                    width: 160.w,
                    height: 75.h,
                    title: "Construction\nWork",
                    imagePath: 'assets/images/construction.png',
                    onTap: () => Get.to(() => const ConstructionAllRequestPage()),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Letters
              CustomTextWidget(
                text: 'Letters',
                fontWeight: FontWeight.bold,
                fontsize: 14.sp,
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomServiceCard(
                    width: 160.w,
                    height: 158.h,
                    title: "Recommendation \nLetter",
                    imagePath: 'assets/images/recommendation.png',
                    onTap: () => Get.to(() => const RecommendationAllRequestPage()),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    children: [
                      CustomServiceCard(
                        width: 160.w,
                        height: 75.h,
                        title: "Complaint\nLetter",
                        imagePath: 'assets/images/complaint.png',
                        onTap: () => Get.to(() => const ComplaintLetterAllRequestPage()),
                      ),
                      SizedBox(height: 8.h),
                      CustomServiceCard(
                        width: 160.w,
                        height: 75.h,
                        title: "Suggestion\nLetter",
                        imagePath: 'assets/images/suggestion.png',
                        onTap: () => Get.to(() => const SuggestionLetterAllRequestPage()),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Requests
              CustomTextWidget(
                text: 'Requests',
                fontWeight: FontWeight.bold,
                fontsize: 14.sp,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  CustomServiceCard(
                    width: 160.w,
                    height: 75.h,
                    title: "Parliament\nVisit",
                    imagePath: 'assets/images/parliament.png',
                    imageBoxFactor: 0.65,
                    onTap: () => Get.to(() => const ParliamentVisitAllrequestPage()),
                  ),
                  SizedBox(width: 8.w),
                  CustomServiceCard(
                    width: 160.w,
                    height: 75.h,
                    title: "Invitation",
                    imagePath: 'assets/images/invitation.png',
                    onTap: () => Get.to(() => const InvitationAllRequestPage()),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}


 */