import 'package:admin_jantasewa/data/complain_data.dart';
import 'package:admin_jantasewa/view/complains/complain_details_screen.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompalainListview extends StatefulWidget {
  const CompalainListview({super.key});

  @override
  State<CompalainListview> createState() => _CompalainListviewState();
}

class _CompalainListviewState extends State<CompalainListview> {
  @override
  Widget build(BuildContext context) {
     final Size screenSize = MediaQuery.of(context).size;
    // final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(text: 'Requested Complain:',fontWeight: FontWeight.bold,color: AppColors.textColor,),
        SizedBox(height: 10,),
        SizedBox(
          height: screenHeight*0.85,
          child: ListView.builder(
            itemCount: complaintList.length,
            itemBuilder: (context, index) {
              final item = complaintList[index];
              return InkWell(
                onTap: (){
                  Get.to(()=>ComplainDetailScreen(),arguments: item);
                },
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.grey,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: "Name : ${item['applicantName']}",
                          color: AppColors.black,
                          fontsize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 5),
                        CustomTextWidget(
                          text: "Mobile : ${item['mobileNumber']}",
                          color: AppColors.textGrey,
                          fontsize: 10,
                        ),
                        SizedBox(height: 10),
                        CustomTextWidget(
                          text: "Message : ${item['briefDetail']}",
                          color: AppColors.textColor,
                          fontsize: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
      
    );
    
  }
}