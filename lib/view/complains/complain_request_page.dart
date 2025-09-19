import 'package:admin_jantasewa/components/complain/compalain_listview.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ComplainRequestPage extends StatefulWidget {
  const ComplainRequestPage({super.key});

  @override
  State<ComplainRequestPage> createState() => _ComplainRequestPageState();
}

class _ComplainRequestPageState extends State<ComplainRequestPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomTopAppBar(
        title: 'Complain',
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
                CompalainListview(),
                SizedBox(height: 10,)
            ],
          ),
        ),
        
      ),
    );
   
  }
}

