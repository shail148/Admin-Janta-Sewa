import 'package:admin_jantasewa/controllers/auth/authorized_user_controller.dart';
import 'package:admin_jantasewa/models/authorized_user_model.dart';
import 'package:admin_jantasewa/routes/app_routes.dart';
import 'package:admin_jantasewa/view/users/authorized_user_detail_screen.dart';
import 'package:admin_jantasewa/view/users/create_autorized_user.dart';
import 'package:admin_jantasewa/constants/colors.dart';
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

    //final c = Get.put(UserController(), permanent: true);
      //final c =Get.find<UserController>();  // get.put in app_binding.dart
      final controller =Get.find<AuthorizedUserController>();

    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSearchBar(
          controller: controller.searchController,
          hint: 'Search....',
          onChanged: controller.setSearch, // live search
          onClear: controller.clearSearch, // resets
          // If your CustomSearchBar does not support onSearchPressed, remove the next line:
          onSearchPressed: () => controller.setSearch(controller.searchController.text),
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
                //Get.to(() => CreateAuthorizedUserPage()); //dont use , can cause global key red screen error later as it pushes new screen on top of a existing screen in navigation stack
                Get.toNamed(AppRoutes.createAuthorizedUserPage);
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
              itemCount: controller.filteredList.length,
              itemBuilder: (context, index) {
                final AuthorizedUserModel authorizedUserModel = controller.filteredList[index];
                return GestureDetector(
                  onTap: () {
                    //Get.to(() => AuthorizedUserDetailScreen(), arguments: authorizedUserModel);
                    Get.toNamed(AppRoutes.authorizedUserDetailScreen, arguments: authorizedUserModel);
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
                            backgroundImage: NetworkImage(authorizedUserModel.profileImageUrl),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: authorizedUserModel.name,
                                  color: AppColors.black,
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 2),
                                CustomTextWidget(
                                  text: authorizedUserModel.userId,
                                  color: AppColors.textGrey,
                                  fontsize: 12,
                                ),
                                SizedBox(height: 2),
                                CustomTextWidget(
                                  text: "Phone: ${authorizedUserModel.phone}",
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
