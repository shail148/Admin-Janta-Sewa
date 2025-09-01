import 'package:admin_jantasewa/components/home/application_chart.dart';
import 'package:admin_jantasewa/components/home/request_carousel_slider.dart';
import 'package:admin_jantasewa/components/service_card.dart';
import 'package:admin_jantasewa/view/construction/workdemand_main_page.dart';
import 'package:admin_jantasewa/view/hospital/hospital_main_page.dart';
import 'package:admin_jantasewa/view/parliamentVisit/parliament_visit_page.dart';
import 'package:admin_jantasewa/view/railTicketBook/rail_ticket_confirmation.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Request Carousel
            RequestCarousel(),
            const SizedBox(height: 20),
            //Application Chart Overview
            ApplicationOverviewChart(),
            const SizedBox(height: 20),
            CustomTextWidget(
              text: 'Services',
              fontWeight: FontWeight.bold,
              fontsize: 14,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ServiceCard(
                  icon: Icons.train,
                  title: "Rail Ticket Confirmation",
                  onTap: () {
                    Get.to(() => RailTicketConfirmationPage());
                  },
                ),
                ServiceCard(
                  icon: Icons.account_balance,
                  title: "Parliament Visit",
                  onTap: () {
                    Get.to(() => ParliamentVisitPage());
                  },
                ),
                ServiceCard(
                  icon: Icons.local_hospital,
                  title: "Hospital Admission",
                  onTap: () {
                    Get.to(() => HospitalMainPage());
                  },
                ),
                ServiceCard(
                  icon: Icons.construction,
                  title: "Construction Work",
                  onTap: () {
                    Get.to(() => WorkDemandMainPage());
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextWidget(
              text: 'Letter & Request',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ServiceCard(
                  icon: Icons.description_outlined,
                  title: "Recommendation Letter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.description_outlined,
                  title: "Complaint Letter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.description_outlined,
                  title: "Suggestion Letter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.description_outlined,
                  title: "Budget Demand",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextWidget(
              text: 'Contact & Invitation',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ServiceCard(
                  icon: Icons.mark_email_unread_outlined,
                  title: "Invitation Letter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.contact_mail_outlined,
                  title: "Contact Information",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
