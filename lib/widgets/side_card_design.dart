import 'package:flutter/material.dart';

class SideCustomCard extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SideCustomCard({
    super.key,
    required this.child,
    this.bgColor = const Color(0xFF2E6ED9), // default like AppColors.btnBgColor
    this.borderRadius = 8,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: bgColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.only(left: 4),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          child: child,
        ),
      ),
    );
  }
}
