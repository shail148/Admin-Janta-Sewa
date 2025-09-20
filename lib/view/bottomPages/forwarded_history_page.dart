import 'package:admin_jantasewa/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:admin_jantasewa/components/requestedServices/request_services_list_screen.dart';

class ForwardedHistoryPage extends StatelessWidget {
  const ForwardedHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available and loads JSON data, controller in app binding under binding folder

    return Scaffold(
      backgroundColor: AppColors.white,

      // Show the list from GetX controller
      body: RequestServicesDataListScreen(),
    );
  }
}
