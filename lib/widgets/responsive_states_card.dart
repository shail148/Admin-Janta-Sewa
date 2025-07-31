import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ResponsiveStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;

  const ResponsiveStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.35; 
    double containerHeight = screenHeight * 0.16;


    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.btnBgColor, width: 2),
        color: AppColors.formBgColor,
      ),
      height: containerHeight,
      width: containerWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.galleryBdColors,
            ),
            height: 40,
            width: 40,
            child: Icon(icon, color: Colors.black, size: 26),
          ),
          //SizedBox(height: 6),
          CustomTextWidget(
            text: title,
            fontsize: 12,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          CustomTextWidget(
            text: count,
            fontWeight: FontWeight.bold,
            fontsize: 14,
          ),
        ],
      ),
    );
  }
}
