import 'package:flutter/material.dart';

class ViewDetailsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color bgColor;
  final double borderRadius;
  final double fontSize;

  const ViewDetailsButton({
    super.key,
    required this.onTap,
    this.text = "View",
    this.bgColor = const Color(0xFF2E6ED9), // Default = AppColors.btnBgColor
    this.borderRadius = 8,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
