import 'package:admin_jantasewa/localization/localization.dart';

// ignore: unused_import
import 'package:admin_jantasewa/view/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Janta Sewa',
      translations: AppLocalization(), 
      locale: const Locale('en', 'US'), 
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:DashboardPage() ,
    );
  }
}
