import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/dotted_divider.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final String requestDate; // e.g. "Requested on 12 Jan, 2024"
  final String idLabel; // e.g. "Ticket ID"
  final String idValue; // e.g. ticketId
  final String userLabel; // e.g. "User ID"
  final String userValue; // e.g. userId
  final String reason;

  const DetailsCard({
    super.key,
    required this.requestDate,
    required this.idLabel,
    required this.idValue,
    required this.userLabel,
    required this.userValue,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFD9D9D9), width: 1),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     blurRadius: 6,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Request Date
          CustomTextWidget(
            text: requestDate,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontsize: 12,
          ),

          const SizedBox(height: 8),

          /// ID Row
          Row(
            children: [
              const Icon(
                Icons.confirmation_number,
                size: 18,
                color: Colors.deepPurple,
              ),
              const SizedBox(width: 6),
              Text(
                "$idLabel: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(idValue),
            ],
          ),

          const SizedBox(height: 6),

          /// User Row
          Row(
            children: [
              const Icon(Icons.badge, size: 18, color: Colors.deepPurple),
              const SizedBox(width: 6),
              Text(
                "$userLabel: ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(userValue),
            ],
          ),

          /// Divider
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: DottedDivider(color: Colors.grey),
          ),

          /// Reason / Message
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.message, color: Color(0xFF403572)),
                const SizedBox(width: 8),

                /// Text section (Message title + actual reason)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF403572),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        reason,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF403572),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
