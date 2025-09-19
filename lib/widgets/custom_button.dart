import 'package:admin_jantasewa/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? textSize;
  final double borderWidth ;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.borderRadius = 8.0,
    this.backgroundColor ,
    this.onPressed,
    required this.textSize, 
    this.textColor = Colors.white,
    this.borderWidth = 1.0,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor??AppColors.btnBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color:borderColor ?? AppColors.btnBgColor,
            width: borderWidth,
          )
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}
