import 'package:admin_jantasewa/models/authorized_user_model.dart';
import 'package:admin_jantasewa/models/user_model.dart';
import 'package:admin_jantasewa/view/auth/languge_switch.dart';
import 'package:admin_jantasewa/view/bottomPages/new_home_page.dart';
import 'package:admin_jantasewa/view/bottomPages/forwarded_history_page.dart';
import 'package:admin_jantasewa/view/dashboard/dashboard.dart';
import 'package:admin_jantasewa/view/drawerPages/settings/report_issue_page.dart';
import 'package:admin_jantasewa/view/users/authorized_user_detail_screen.dart';
import 'package:admin_jantasewa/view/users/authorized_user_edit_screen.dart';
import 'package:admin_jantasewa/view/users/create_autorized_user.dart';
import 'package:admin_jantasewa/view/users/user_detail_screen.dart';
import 'package:admin_jantasewa/view/users/user_edit_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.reportissue, page: () => ReportIssuePage()),
    GetPage(name: AppRoutes.languageswitch, page: () => LanguageSwitch()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardPage()),
    GetPage(
      name: AppRoutes.requestPage,
      page: () => const ForwardedHistoryPage(),
    ),
    GetPage(name: AppRoutes.newHomePage, page: () => const NewHomePage()),
    GetPage(name: AppRoutes.userDetailScreen, page: () => const UserDetailScreen()),
    GetPage(name: AppRoutes.authorizedUserDetailScreen, page: () => const AuthorizedUserDetailScreen()),
    GetPage(name: AppRoutes.createAuthorizedUserPage, page: () => const CreateAuthorizedUserPage()),

     GetPage(
      name: AppRoutes.userEditScreen,
      page: () => UserEditScreen(
        user: Get.arguments as UserModel, // get the UserModel passed in arguments
      ),
    ),

    GetPage(
      name: AppRoutes.authorizedUserEditScreen,
      page: () => AuthorizedUserEditScreen(
        authorizedUserModel: Get.arguments as AuthorizedUserModel, // get the Authorized UserModel passed in arguments
      ),
    )
    
    ];

     


}
              
