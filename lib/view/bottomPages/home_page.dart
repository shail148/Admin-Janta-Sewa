import 'package:admin_jantasewa/components/home/application_chart.dart';
import 'package:admin_jantasewa/components/home/request_carousel_slider.dart';
import 'package:admin_jantasewa/components/service_card.dart';
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Request Carousel 
            RequestCarousel(),
            const SizedBox(height: 10),
            //Application Chart Overview
            ApplicationOverviewChart(),
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
                  title: "Rail Ticket\nConfirmation",
                  onTap: () {
                    Get.to(() => RailTicketConfirmationPage());
                  },
                ),
                ServiceCard(
                  icon: Icons.account_balance,
                  title: "Parliament\nVisit",
                  onTap: () {
                    Get.to(() => ParliamentVisitPage());
                  },
                ),
                ServiceCard(
                  icon: Icons.local_hospital,
                  title: "Hospital\nAdmission",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.construction,
                  title: "Construction\nWork",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                  title: "Recommendation\nLetter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.description_outlined,
                  title: "Complaint\nLetter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.description_outlined,
                  title: "Suggestion\nLetter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.description_outlined,
                  title: "Budget\nDemand",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
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
                  title: "Invitation\nLetter",
                  onTap: () {},
                ),
                ServiceCard(
                  icon: Icons.contact_mail_outlined,
                  title: "Contact\nInformation",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
