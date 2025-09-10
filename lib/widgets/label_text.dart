import 'package:flutter/material.dart';

class CustomLabelText extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color? color;
  final bool isRequired;
  const CustomLabelText({
    super.key,
    required this.text,
    this.fontsize = 14,
    this.color,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontsize,
          color: color ?? Colors.black54,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: fontsize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
