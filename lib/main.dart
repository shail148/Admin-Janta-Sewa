import 'package:admin_jantasewa/bindings/app_bindings.dart';
import 'package:admin_jantasewa/controllers/language/language_controller.dart';
import 'package:admin_jantasewa/localization/localization.dart';
import 'package:admin_jantasewa/routes/app_pages.dart';
import 'package:admin_jantasewa/routes/app_routes.dart';
// ignore: unused_import
import 'package:admin_jantasewa/view/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
    //Get.put(LanguageController()); //i put in app_binding.dart

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Janta Sewa',
      
        //added for routes
        initialRoute: AppRoutes.dashboard,
        getPages: AppPages.pages,
        initialBinding: AppBinding(), // Inject all controllers here
      
        translations: AppLocalization(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // Initial route
        //home: DashboardPage(),
      
        // Define the initial route
      ),
    );
  }
}
