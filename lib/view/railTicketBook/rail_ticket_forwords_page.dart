import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forwording_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RailTicketForwordsPage extends StatefulWidget {
  const RailTicketForwordsPage({super.key});

  @override
  State<RailTicketForwordsPage> createState() => _RailTicketForwordsPageState();
}

class _RailTicketForwordsPageState extends State<RailTicketForwordsPage> {
  String? selectedForwardPerson;
  String? selectedPriority;

  String message = '';

  final List<String> forwardPersonList = ['Person 1', 'Person 2', 'Person 3'];

  final List<String> priorityList = ['Normal', 'High', 'Urgent'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Train Ticket Confirmation',
        fontsize: 18,
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),
      body: CustomForwardingForm(
        forwardPersonList: forwardPersonList,
        priorityList: priorityList,
        selectedForwardPerson: selectedForwardPerson,
        selectedPriority: selectedPriority,
        onForwardPersonChanged: (val) =>
            setState(() => selectedForwardPerson = val),
        onPriorityChanged: (val) => setState(() => selectedPriority = val),
        onMessageChanged: (val) => setState(() => message = val),
        onCancel: () => Navigator.pop(context),
        onSend: () {
         // print("Message Sent: $message");
        },
      ),
    );
  }
}
