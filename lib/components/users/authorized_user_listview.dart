import 'package:admin_jantasewa/controllers/user_controller.dart';
import 'package:admin_jantasewa/models/user_model.dart';
import 'package:admin_jantasewa/view/users/create_autorized_user.dart';
import 'package:admin_jantasewa/view/users/user_detail_screen.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_search_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorizedUserListview extends StatefulWidget {
  const AuthorizedUserListview({super.key});

  @override
  State<AuthorizedUserListview> createState() => _AuthorizedUserListviewState();
}

class _AuthorizedUserListviewState extends State<AuthorizedUserListview> {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(UserController(), permanent: true);
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSearchBar(
          controller: c.searchController,
          hint: 'Search....',
          onChanged: c.setSearch, // live search
          onClear: c.clearSearch, // resets
          // If your CustomSearchBar does not support onSearchPressed, remove the next line:
          onSearchPressed: () => c.setSearch(c.searchController.text),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              text: "Authorized User",
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              fontsize: 16,
            ),
            CustomButton(
              text: "Add",
              textSize: 14,
              onPressed: () {
                Get.to(() => CreateAuthorizedUserPage());
              },
              height: 35,
            ),
          ],
        ),
        SizedBox(height: 8),
        Obx(
          () => SizedBox(
            height: screenHeight * 0.74,
            child: ListView.builder(
              itemCount: c.filteredList.length,
              itemBuilder: (context, index) {
                final UserModel user = c.filteredList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => UserDetailScreen(), arguments: user);
                  },
                  child: Card(
                    elevation: 0,
                    color: AppColors.white,
                    //add border
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.textColor.withAlpha(50),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(user.profileImageUrl),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: user.name,
                                  color: AppColors.black,
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 2),
                                CustomTextWidget(
                                  text: user.userId,
                                  color: AppColors.textGrey,
                                  fontsize: 12,
                                ),
                                SizedBox(height: 2),
                                CustomTextWidget(
                                  text: "Phone: ${user.phone}",
                                  color: AppColors.textGrey,
                                  fontsize: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
