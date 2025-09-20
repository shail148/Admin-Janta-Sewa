// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:admin_jantasewa/components/custom_dropdown.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  _SendNotificationPageState createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedNotificationType = 'SMS';
  String? _selectedPriorityLevel = 'Normal';
  String? _selectedTargetAudience = 'All Users';
  String? _selectedScheduleTime = 'Send Now';

  DateTime? _scheduledDateTime;

  final List<String> notificationTypes = ['SMS', 'Email', 'In-App'];
  final List<String> priorityLevels = ['Normal', 'High', 'Urgent'];
  final List<String> targetAudiences = [
    'All Users',
    'Staff Only',
    'Specific Role',
    'Custom List',
  ];
  final List<String> scheduleTimes = ['Send Now', 'Schedule'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Notifications',
        leftIcon: const Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Title
            CustomLabelText(text: "Notification Title"),
            const SizedBox(height: 6),
            CustomTextFormField(
              hintText: 'Your Rail Ticket is Approved',
              controller: _titleController,
            ),
            const SizedBox(height: 16),

            // Message
            CustomLabelText(text: "Message"),
            const SizedBox(height: 6),
            CustomTextFormField(
              hintText: 'Text Area (Max 250 chars)',
              maxLines: 6,
              minLines: 3,
              controller: _messageController,
            ),
            const SizedBox(height: 16),

            // Notification Type & Priority Level
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: "Notification Type"),
                      const SizedBox(height: 6),
                      CustomDropdown(
                        items: notificationTypes,
                        selectedValue: _selectedNotificationType,
                        onChanged: (val) =>
                            setState(() => _selectedNotificationType = val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: "Priority Level"),
                      const SizedBox(height: 6),
                      CustomDropdown(
                        items: priorityLevels,
                        selectedValue: _selectedPriorityLevel,
                        onChanged: (val) =>
                            setState(() => _selectedPriorityLevel = val),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Target Audience & Schedule Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: "Target Audience"),
                      const SizedBox(height: 6),
                      CustomDropdown(
                        items: targetAudiences,
                        selectedValue: _selectedTargetAudience,
                        onChanged: (val) =>
                            setState(() => _selectedTargetAudience = val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: "Schedule Time"),
                      const SizedBox(height: 6),
                      CustomDropdown(
                        items: scheduleTimes,
                        selectedValue: _selectedScheduleTime,
                        onChanged: (val) {
                          setState(() {
                            _selectedScheduleTime = val;
                            _scheduledDateTime = null; // reset
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Date & Time Picker if "Schedule" selected
            if (_selectedScheduleTime == 'Schedule')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabelText(text: "Select Date & Time"),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _scheduledDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: Text(
                        _scheduledDateTime != null
                            ? "${_scheduledDateTime!.toLocal()}".split('.')[0]
                            : "Pick date & time",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),

            SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  height: 60,
                  width: 150,
                  text: 'Cancel',
                  textSize: 16,
                  onPressed: () => Get.back(),
                  backgroundColor: Colors.white,
                  textColor: AppColors.btnBgColor,
                ),
                const SizedBox(width: 16),
                CustomButton(
                  height: 60,
                  width: 150,
                  text: _selectedScheduleTime == 'Schedule'
                      ? 'Schedule'
                      : 'Send',
                  textSize: 16,
                  onPressed: () {
                    if (_selectedScheduleTime == 'Schedule') {
                      if (_scheduledDateTime == null) {
                        CustomSnackbar.showError(
                          title: 'Error',
                          message: 'Please pick a date & time first',
                        );
                        return;
                      }
                      CustomSnackbar.showSuccess(
                        title: 'Scheduled',
                        message:
                            'Notification scheduled for $_scheduledDateTime',
                      );
                    } else {
                      CustomSnackbar.showSuccess(
                        title: 'Success',
                        message: 'Notification sent successfully',
                      );
                    }
                    //  Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
