import 'package:admin_jantasewa/data/users_data.dart';
import 'package:admin_jantasewa/view/users/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:get/get.dart';
class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: 'User List:',
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: screenHeight * 0.85,
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final item = userList[index];
              return InkWell(
                onTap: (){
                  Get.to(()=>UserDetailScreen(),arguments: item);
                },
                child: Card(
                  
                  color: AppColors.galleryBdColors,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: "Name: ${item['name']}",
                          color: AppColors.black,
                          fontsize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 4),
                        CustomTextWidget(
                          text: "Email: ${item['email']}",
                          color: AppColors.textGrey,
                          fontsize: 12,
                        ),
                        const SizedBox(height: 4),
                        CustomTextWidget(
                          text: "Phone: ${item['mobile']}",
                          color: AppColors.textGrey,
                          fontsize: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
