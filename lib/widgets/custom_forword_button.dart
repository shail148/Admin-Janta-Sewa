import 'package:flutter/material.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:flutter_svg/svg.dart';

class CustomForwardButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomForwardButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      child: SvgPicture.asset(
        'assets/icons/forward_icon.svg',
        fit: BoxFit.cover,
        width: 30,
        height: 30,
      ),
    );
  }
}
