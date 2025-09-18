import 'package:admin_jantasewa/view/bottomPages/new_home_page.dart';
import 'package:admin_jantasewa/view/bottomPages/send_notification_dashboard.dart';
import 'package:admin_jantasewa/view/drawerPages/custom_drawer.dart';
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
    bool startEditing = false; //for open in editing mode on profile screen in nav bar
    late List<Widget> pages;


  /* final List<Widget> pages = [
    NewHomePage(),
    SendNotificationDashboard(),
    Requestpage(),
    ProfileScreen(),
  ]; */

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      if (args['index'] != null) selectedIndex = args['index'];
      startEditing = args['edit'] == true;
    }
    
    pages = [
    NewHomePage(),
    SendNotificationDashboard(),
    Requestpage(),
    ProfileScreen(startEditing: startEditing),

  ];

  }

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
        leftIcon: Image.asset("assets/icons/menus.png", height: 25),
        onLeftTap: () => _scaffoldKey.currentState?.openDrawer(),
        rightIcon: Icon(
          Icons.notifications,
          color: AppColors.primary,
          size: 30,
        ),
        onRightTap: () {
          Get.to(() => NotificationAppbarPage());
        },
      ),
      drawer: CustomDrawer(),
      body: pages[selectedIndex],

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration:  BoxDecoration(
          color: Color(0xFFF4F6FE),
          /* borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ), */
          //borderRadius: BorderRadius.circular(8.0)
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(Icons.home_outlined, "Home", 0),
            buildNavItem(Icons.dashboard_customize_outlined, "Dashboard", 1),
            buildNavItem(Icons.history, "Request", 2),
            buildNavItem(Icons.person_outline, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.btnBgColor.withOpacity(0.1)
              : Colors.transparent,
          //borderRadius: BorderRadius.circular(20),
          borderRadius: BorderRadius.circular(12),

        ),
        child: Row(
          children: [
            Icon(
              icon,
              //size: 24,
              size: 30,
              color: isSelected ? AppColors.primary : AppColors.primary,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
