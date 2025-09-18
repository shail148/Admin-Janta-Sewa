import 'package:admin_jantasewa/components/users/authorized_user_listview.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorizedUserListPage extends StatefulWidget {
  const AuthorizedUserListPage({super.key});

  @override
  State<AuthorizedUserListPage> createState() => _AuthorizedUserListPageState();
}

class _AuthorizedUserListPageState extends State<AuthorizedUserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Janta Sewa',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //list view of the User Details
              AuthorizedUserListview(),
            ],
          ),
        ),
      ),
    );
  }
}
