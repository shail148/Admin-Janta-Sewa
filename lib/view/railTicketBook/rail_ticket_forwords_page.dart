import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:admin_jantasewa/widgets/custom_drop_down.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:get/get.dart';

class RailTicketForwordsPage extends StatefulWidget {
  const RailTicketForwordsPage({super.key});

  @override
  State<RailTicketForwordsPage> createState() => _RailTicketForwordsPageState();
}
class _RailTicketForwordsPageState extends State<RailTicketForwordsPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedForwardTo;
  String? selectedForwardPerson;
  String? selectedPriority;
  final TextEditingController _messageController = TextEditingController();

  final List<String> forwardToList = [
    'MP Office',
    'Constituency Office',
    'Other',
  ];

  final List<String> priorityList = [
    'Normal',
    'High',
    'Urgent',
  ];

  final List<String> forwardPersonList = [
    'Person 1',
    'Person 2',
    'Person 3',
    'Person 4',
    'Person 5',
    'Person 6',
  ];

  Widget buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return CustomDropdown(
      items: items,
      selectedValue: value,
      onChanged: onChanged,
      hintText: hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Ticket Forword Details',
        fontsize: 16,
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              CustomLabelText(text: 'Forward to', fontsize: 14, color: Colors.black),
              buildDropdown(
                hint: 'Select Destination',
                value: selectedForwardTo,
                items: forwardToList,
                onChanged: (val) => setState(() => selectedForwardTo = val),
              ),
              const SizedBox(height: 16),
              CustomLabelText(text: 'Forward Person', fontsize: 14, color: Colors.black),
              buildDropdown(
                hint: 'Select Person',
                value: selectedForwardPerson,
                items: forwardPersonList,
                onChanged: (val) => setState(() => selectedForwardPerson = val),
              ),
              const SizedBox(height: 16),
              CustomLabelText(text: 'Priority', fontsize: 14, color: Colors.black),
              buildDropdown(
                hint: 'Select Priority',
                value: selectedPriority,
                items: priorityList,
                onChanged: (val) => setState(() => selectedPriority = val),
              ),
              const SizedBox(height: 16),
              CustomLabelText(text: 'Message', fontsize: 14, color: Colors.black),
              TextFormField(
                controller: _messageController,
                maxLength: 250,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter Messages',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                       height: 60,
                      width: 100,
                      textSize: 16,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor:AppColors.btnBgColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      height: 60,
                      width: 100,
                      text: 'Send',
                      textSize: 16,
                      backgroundColor: AppColors.btnBgColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // send action
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
