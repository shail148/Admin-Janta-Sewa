import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class FormFieldConfig {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Validator? validator;

  FormFieldConfig({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });
}
class DynamicForm extends StatelessWidget {
  final List<FormFieldConfig> fields;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;
  final String submitText;

  const DynamicForm({
    super.key,
    required this.fields,
    required this.formKey,
    required this.onSubmit,
    this.submitText = "Submit",
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          ...fields.map((f) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              controller: f.controller,
              obscureText: f.obscureText,
              keyboardType: f.keyboardType,
              decoration: InputDecoration(labelText: f.label),
              validator: f.validator,
            ),
          )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text(submitText),
          ),
        ],
      ),
    );
  }
}
