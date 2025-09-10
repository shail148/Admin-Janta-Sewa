import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final bool showPercentage;

  const CustomCircularProgress({
    super.key,
    required this.progress,
    this.size = 60,
    this.strokeWidth = 6,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Circle
          CircularProgressIndicator(
            value: 1,
            strokeWidth: strokeWidth,
            color: backgroundColor,
          ),
          // Foreground Progress
          CircularProgressIndicator(
            value: progress,
            strokeWidth: strokeWidth,
            color: progressColor,
          ),
          // Percentage Text
          if (showPercentage)
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: size * 0.25,
                fontWeight: FontWeight.bold,
                color: progressColor,
              ),
            ),
        ],
      ),
    );
  }
}
