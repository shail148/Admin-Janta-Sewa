import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String? title ;

  const CustomTopAppBar({
    super.key,
    this.onLeftTap,
    this.onRightTap,
    this.leftIcon,
    this.rightIcon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: leftIcon != null
          ? IconButton(
              onPressed: onLeftTap,
              icon: leftIcon!,
              color: AppColors.btnBgColor,
              iconSize: 24,
            )
          : null,
      actions: [
        if (rightIcon != null)
          IconButton(onPressed: onRightTap, icon: rightIcon!),
      ],
      elevation: 0,
      // backgroundColor: Colors.white,
      title: CustomTextWidget(
        text: title ??'Janta Sewa',
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
        fontsize: 24,
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
