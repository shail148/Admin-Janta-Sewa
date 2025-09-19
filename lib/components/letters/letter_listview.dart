
import 'package:admin_jantasewa/data/letters_data.dart';
import 'package:admin_jantasewa/view/letters/letter_details_screen.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LetterListview extends StatefulWidget {
  const LetterListview({super.key});

  @override
  State<LetterListview> createState() => _LetterListviewState();
}

class _LetterListviewState extends State<LetterListview> {
  @override
  Widget build(BuildContext context) {
       final Size screenSize = MediaQuery.of(context).size;
    // final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(text: 'Requested Letters:',fontWeight: FontWeight.bold,color: AppColors.textColor,),
        SizedBox(height: 10,),
        SizedBox(
          height: screenHeight*0.85,
          child: ListView.builder(
            itemCount: lettersData.length,
            itemBuilder: (context, index) {
              final item = lettersData[index];
              return InkWell(
                onTap: () {
                  Get.to(()=>LetterDetailScreen(),arguments: item);
                },
                child: Card(
                  color: AppColors.galleryBdColors,
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