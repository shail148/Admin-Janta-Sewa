import 'package:admin_jantasewa/controllers/language/language_controller.dart';
import 'package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart';
import 'package:admin_jantasewa/controllers/requestService/request_service_controller.dart';
import 'package:admin_jantasewa/controllers/settings/report_issue_controller.dart';
import 'package:admin_jantasewa/controllers/settings/setting_controller.dart';
import 'package:get/get.dart';



class AppBinding extends Bindings {
  @override
  void dependencies() {

    //  lazyput Auto recreate when needed
    Get.lazyPut<ReportIssueController>(() => ReportIssueController(), fenix: true);
    Get.put<LanguageController>(LanguageController(), permanent: true);
   
   
    Get.put<SettingsController>(SettingsController(), permanent: true);

    Get.put<RailTicketController>(RailTicketController(), permanent: true);

    Get.put<RequestServicesController>(RequestServicesController(), permanent: true);





  }
}
