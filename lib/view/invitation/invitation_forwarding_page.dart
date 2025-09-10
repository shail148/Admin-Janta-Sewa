import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forwording_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitationForwardingPage extends StatefulWidget {
  const InvitationForwardingPage({super.key});

  @override
  State<InvitationForwardingPage> createState() =>
      _InvitationForwardingPageState();
}

class _InvitationForwardingPageState extends State<InvitationForwardingPage> {
  String? selectedForwardTo;
  String? selectedForwardPerson;
  String? selectedPriority;
  final TextEditingController _messageController = TextEditingController();

  final List<String> priorityList = ['Normal', 'High', 'Urgent'];

  final List<String> forwardPersonList = [
    'Person 1',
    'Person 2',
    'Person 3',
    'Person 4',
    'Person 5',
    'Person 6',
    'Person 7',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Invitation Forwarding',
        fontsize: 16,
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
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
        onMessageChanged: (val) =>
            setState(() => _messageController.text = val),
        onCancel: () => Navigator.pop(context),
        onSend: () {
          // print("Message Sent: ${_messageController.text}");
        },
      ),
    );
  }
}
