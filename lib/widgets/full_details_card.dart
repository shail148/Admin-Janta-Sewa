import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:flutter/material.dart';

class FullDetailsCard extends StatelessWidget {
  final String title;
  final Map<String, String> details;

  const FullDetailsCard({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xffFCFCFC),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0x80D9D9D9)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            CustomLabelText(text: title, color: AppColors.black, fontsize: 14),
            Divider(thickness: 1, color: Colors.grey.shade300),

            /// Dynamic Rows
            ...details.entries.map(
              (entry) => _buildRow(entry.key, entry.value),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Row for details
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label (left, top-aligned)
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Value (right, top-aligned, wraps below label if long)
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
