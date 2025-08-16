import 'package:admin_jantasewa/data/requested_service_data.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RequestServicesData extends StatefulWidget {
  const RequestServicesData({super.key});

  @override
  State<RequestServicesData> createState() => _RequestServicesDataState();
}

class _RequestServicesDataState extends State<RequestServicesData> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(text: 'Requested Servies:',fontWeight: FontWeight.bold,color: AppColors.textColor,),
        SizedBox(height: 10,),
        SizedBox(
          height: screenHeight*0.75,
          child: ListView.builder(
            itemCount: requestedServices.length,
            itemBuilder: (context, index) {
              final item = requestedServices[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
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
                          text: item['title'],
                          color: AppColors.black,
                          fontsize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 5),
                        CustomTextWidget(
                          text: item['message'],
                          color: AppColors.textGrey,
                          fontsize: 10,
                        ),
                        SizedBox(height: 10),
                        CustomTextWidget(
                          text: item['date'],
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
