import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_forwording_form.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class ConstructionForwardPage extends StatefulWidget {
  const ConstructionForwardPage({super.key});

  @override
  State<ConstructionForwardPage> createState() =>
      _ConstructionForwardPageState();
}

class _ConstructionForwardPageState extends State<ConstructionForwardPage> {
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
        title: 'Construction Forwarding',
        fontsize: 16,
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: CustomForwardingForm(
        forwardPersonList: forwardPersonList,
        priorityList: priorityList,
        onForwardPersonChanged: (value) {
          setState(() {
            selectedForwardPerson = value;
          });
        },
        onPriorityChanged: (value) {
          setState(() {
            selectedPriority = value;
          });
        },
        onMessageChanged: (value) {
          _messageController.text = value;
        },
        onSend: () {
          // Handle send action
        },
        onCancel: () {
          // Handle cancel action
        },
      ),
    );
  }
}
