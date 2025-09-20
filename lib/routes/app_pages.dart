import 'package:admin_jantasewa/view/auth/languge_switch.dart';
import 'package:admin_jantasewa/view/bottomPages/new_home_page.dart';
import 'package:admin_jantasewa/view/bottomPages/request_page.dart';
import 'package:admin_jantasewa/view/dashboard/dashboard.dart';
import 'package:admin_jantasewa/view/drawerPages/settings/report_issue_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.reportissue, page: () => ReportIssuePage()),
    GetPage(name: AppRoutes.languageswitch, page: () => LanguageSwitch()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardPage()),
    GetPage(name: AppRoutes.requestPage, page: () => const RequestPage()),
    GetPage(name: AppRoutes.newHomePage, page: () => const NewHomePage()),
  ];
}
