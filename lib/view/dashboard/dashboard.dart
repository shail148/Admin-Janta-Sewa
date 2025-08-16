import 'package:admin_jantasewa/view/bottomPages/send_notification_dashboard.dart';
import 'package:admin_jantasewa/view/drawerPages/custom_drawer.dart';
import 'package:admin_jantasewa/view/bottomPages/home_page.dart';
import 'package:admin_jantasewa/view/bottomPages/profile_page.dart';
import 'package:admin_jantasewa/view/bottomPages/request_page.dart';
import 'package:admin_jantasewa/view/notification/notification_appbar.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    HomePage(),
    SendNotificationDashboard(),
    Requestpage(),
    ProfileScreen(),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomTopAppBar(
        leftIcon: Icon(Icons.menu, color: AppColors.btnBgColor, size: 30),
        onLeftTap: () => _scaffoldKey.currentState?.openDrawer(),
        rightIcon: Icon(
          Icons.notifications,
          color: AppColors.btnBgColor,
          size: 30,
        ),
        onRightTap: () {
          Get.to(()=>NotificationAppbarPage());
        },
      ),
      drawer: CustomDrawer(),
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF4F6FE),
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,

          selectedItemColor: AppColors.btnBgColor,
          unselectedItemColor: AppColors.textGrey,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.send, size: 30),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page_outlined, size: 30),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 30),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
