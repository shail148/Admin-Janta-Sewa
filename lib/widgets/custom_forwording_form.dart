import 'package:flutter/material.dart';
import 'package:admin_jantasewa/widgets/custom_drop_down.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/constants/colors.dart';

class CustomForwardingForm extends StatefulWidget {
  final List<String> forwardPersonList;
  final List<String> priorityList;

  final String? selectedForwardPerson;
  final String? selectedPriority;

  final Function(String?) onForwardPersonChanged;
  final Function(String?) onPriorityChanged;
  final Function(String) onMessageChanged;

  final VoidCallback onSend;
  final VoidCallback onCancel;

  const CustomForwardingForm({
    super.key,
    required this.forwardPersonList,
    required this.priorityList,
    this.selectedForwardPerson,
    this.selectedPriority,
    required this.onForwardPersonChanged,
    required this.onPriorityChanged,
    required this.onMessageChanged,
    required this.onSend,
    required this.onCancel,
  });

  @override
  State<CustomForwardingForm> createState() => _CustomForwardingFormState();
}

class _CustomForwardingFormState extends State<CustomForwardingForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Forward Person
              CustomLabelText(
                text: 'Forward Person',
                fontsize: 14,
                color: const Color(0xff626262),
              ),
              buildDropdown(
                hint: 'Select Person',
                value: widget.selectedForwardPerson,
                items: widget.forwardPersonList,
                onChanged: widget.onForwardPersonChanged,
              ),

              const SizedBox(height: 16),

              /// Priority
              CustomLabelText(
                text: 'Priority',
                fontsize: 14,
                color: const Color(0xff626262),
              ),
              buildDropdown(
                hint: 'Select Priority',
                value: widget.selectedPriority,
                items: widget.priorityList,
                onChanged: widget.onPriorityChanged,
              ),

              const SizedBox(height: 16),

              /// Message
              CustomLabelText(
                text: 'Message',
                fontsize: 14,
                color: const Color(0xff626262),
              ),
              const SizedBox(height: 8),
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
                onChanged: widget.onMessageChanged,
              ),

              const SizedBox(height: 50),

              /// Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Cancel',
                    height: 40,
                    width: 100,
                    textSize: 14,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    borderColor: AppColors.primary,
                    onPressed: widget.onCancel,
                  ),
                  const SizedBox(width: 12),
                  CustomButton(
                    height: 40,
                    width: 100,
                    text: 'Send',
                    textSize: 14,
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSend();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
