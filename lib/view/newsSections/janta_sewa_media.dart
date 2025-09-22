import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';
import 'package:admin_jantasewa/view/newsSections/top_tabs.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'banner_tab.dart';
import 'speech_tab.dart';
import 'gallery_tab.dart';

class JantaSewaMedia extends StatelessWidget {
  const JantaSewaMedia({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MediaUploadController());

    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Media',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () {
          Get.back();
        },
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const TopTabs(),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  BannerTab(controller: c),
                  SpeechTab(controller: c),
                  GalleryTab(controller: c),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
