import 'package:admin_jantasewa/components/letters/letter_listview.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LettersRequestPage extends StatefulWidget {
  const LettersRequestPage({super.key});

  @override
  State<LettersRequestPage> createState() => _LettersRequestPageState();
}

class _LettersRequestPageState extends State<LettersRequestPage> {
  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: CustomTopAppBar(
        title: 'Letters',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [    
                LetterListview(),
                SizedBox(height: 10,)
            ],
          ),
        ),
        
      ),
    );
  }
}