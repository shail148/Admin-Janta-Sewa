import 'package:admin_jantasewa/models/authorized_user_model.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/routes/app_routes.dart';
import 'package:admin_jantasewa/view/users/authorized_user_edit_screen.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_delete_dialog_box.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Details Screen of the Users
class AuthorizedUserDetailScreen extends StatelessWidget {

  
  const AuthorizedUserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authorizedUser = Get.arguments as AuthorizedUserModel;
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Authorized User Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        rightIcon: CustomPopupMenu(
          onSelected: (value) {
            if (value == "Edit") {
               // Navigate to the UserEditScreen and pass the user data
           //Get.to(() => AuthorizedUserEditScreen(authorizedUser: authorizedUser));
           //Get.to(() => AuthorizedUserEditScreen(authorizedUserModel: authorizedUser));
           Get.toNamed(AppRoutes.authorizedUserEditScreen,arguments: authorizedUser);

            } else if (value == "Inactive") {
              if (kDebugMode) {
                print("Marked as inactive");
              }
            } else if (value == "Delete") {
              // print("Deleted");
              DeleteDialog.show(
                onConfirm: () {
                  //  delete action write here
                  if (kDebugMode) {
                    print("Record Deleted!");
                  }
                },
                onCancel: () {
                  if (kDebugMode) {
                    print("Cancel pressed");
                  }
                },
              );
            }
          },
        ),

        onLeftTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(authorizedUser.profileImageUrl),
                ),
              ),
              CustomTextWidget(
                text: authorizedUser.userId,
                fontWeight: FontWeight.bold,
                fontsize: 16,
              ),
              CustomTextWidget(text: authorizedUser.email),
              SizedBox(height: 8),
              DetailsCard(
                title: "Personal Details",
                details: {
                  "Full Name:": authorizedUser.name,
                  "Date of Birth:": authorizedUser.dob,
                  "Gender:": authorizedUser.gender,
                  "Nationality": authorizedUser.nationality,
                  "Phone Number": authorizedUser.phone,
                  "Email": authorizedUser.email,
                },
              ),
              DetailsCard(
                title: "Location Details",
                details: {
                  "Address:": authorizedUser.address,
                  "State:": authorizedUser.state,
                  "District:": authorizedUser.district,
                  "City/Village": authorizedUser.cityVillage,
                  "Ward Number": authorizedUser.wardNumber,
                  "Pin Code": authorizedUser.pincode,
                  
                },
              ),
              DetailsCard(
                title: "Authorized Level",
                details: {
                  "Select Post": authorizedUser.selectedPost,
                  "Forwarded Level": authorizedUser.forwardedLevel,
                },
              ),
              DetailsCard(
                title: "Account Details",
                details: {
                  "Account Created:": authorizedUser.accountCreated,
                  "Last Login:": authorizedUser.lastLogin,
                  "Status:": authorizedUser.status,
                },
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  final String title;
  final Map<String, String> details;

  const DetailsCard({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xffFCFCFC),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0x80D9D9D9)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            CustomLabelText(text: title, color: AppColors.black, fontsize: 14),
            Divider(thickness: 1, color: Colors.grey.shade300),

            /// Dynamic Rows
            ...details.entries.map(
              (entry) => _buildRow(entry.key, entry.value),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Row for details
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label (left, top-aligned)
          Expanded(
            flex: 2,
            child: Align(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Value (right, top-aligned, wraps below label if long)
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                value,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPopupMenu extends StatelessWidget {
  final Function(String) onSelected;

  const CustomPopupMenu({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: onSelected,
      itemBuilder: (context) => const [
        PopupMenuItem(value: "Edit", child: Text("Edit")),
        PopupMenuItem(value: "Inactive", child: Text("In active")),
        PopupMenuItem(value: "Delete", child: Text("Delete")),
      ],
      child: const Icon(Icons.more_vert, color: AppColors.primary),
    );
  }
}
