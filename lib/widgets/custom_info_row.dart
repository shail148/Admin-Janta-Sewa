import 'package:flutter/material.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';

class CustomInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final int labelFlex;
  final int valueFlex;

  const CustomInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelFlex = 4,
    this.valueFlex = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: labelFlex,
            child: CustomLabelText(text: label, color: AppColors.textGrey),
          ),
          Expanded(
            flex: valueFlex,
            child: CustomTextWidget(text: value, fontsize: 14),
          ),
        ],
      ),
    );
  }
}
