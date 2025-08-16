import 'package:admin_jantasewa/view/railTicketBook/rail_ticket_forwords_page.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RailTicketDetailsPage extends StatefulWidget {
  const RailTicketDetailsPage({super.key});

  @override
  State<RailTicketDetailsPage> createState() => _RailTicketDetailsPageState();
}

class _RailTicketDetailsPageState extends State<RailTicketDetailsPage> {
  // Dummy data for demonstration
  final trainDetails = {
    'PNR Number': '9568235',
    'Journey Date': '10-05-2025',
    'Train Number': '9865325',
    'Train Name': 'Rajdhani',
    'From': 'Mumbai Central',
    'To': 'Prayagraj',
  };

  final passengers = [
    {
      'name': 'Rahul Sharma',
      'age': '18',
      'gender': 'Male',
      'mobile': '9563214566',
      'nationality': 'Indian',
    },
    {
      'name': 'Priya Singh',
      'age': '22',
      'gender': 'Female',
      'mobile': '9876543210',
      'nationality': 'Indian',
    },
    {
      'name': 'Amit Kumar',
      'age': '30',
      'gender': 'Male',
      'mobile': '9123456789',
      'nationality': 'Indian',
    },
  ];

  final documents = [
    {'name': 'Ticket. PNG', 'size': '2.1 MB'},
    {'name': 'Ticket. PNG', 'size': '2.1 MB'},
    {'name': 'Ticket. PNG', 'size': '2.1 MB'},
  ];

  List<bool> passengerExpanded = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Train Ticket Details',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Train Details
              CustomLabelText(
                text: 'Train Details',
                color: AppColors.btnBgColor,
                fontsize: 16,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: 'PNR Number', color: Colors.grey),
                      CustomTextWidget(
                        text: trainDetails['PNR Number']!,
                        fontsize: 12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: 'Journey Date', color: Colors.grey),
                      CustomTextWidget(text: trainDetails['Journey Date']!,fontsize: 12,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: 'Train Number', color: Colors.grey),
                      CustomTextWidget(text: trainDetails['Train Number']!,fontsize: 12,),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: 'Train Name', color: Colors.grey),
                      CustomTextWidget(text: trainDetails['Train Name']!,fontsize: 12,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: 'From', color: Colors.grey),
                      CustomTextWidget(text: trainDetails['From']!,fontsize: 12,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(text: 'To', color: Colors.grey),
                      CustomTextWidget(text: trainDetails['To']!,fontsize: 12,),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
                height: 32,
              ),
              SizedBox(height: 16),
              CustomLabelText(
                text: 'Passenger Details',
                color: AppColors.btnBgColor,
                fontsize: 16,
              ),
              SizedBox(height: 8),
              ...List.generate(passengers.length, (i) {
                return Column(
                  children: [
                    Card(
                      elevation: 2,
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          trailing: Icon(
                            Icons.expand_more,
                            color: AppColors.btnBgColor,
                          ),
                          leading: Icon(
                            Icons.person_outline,
                            color: AppColors.btnBgColor,
                          ),
                          title: CustomTextWidget(text: 'Passenger ${i + 1}',),
                          initiallyExpanded: passengerExpanded[i],
                          onExpansionChanged: (expanded) {
                            setState(() {
                              passengerExpanded[i] = expanded;
                            });
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomLabelText(
                                            text: 'Name:',
                                            fontsize: 12,
                                          ),
                                          CustomTextWidget(
                                            text: passengers[i]['name']!,fontsize: 12,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomLabelText(
                                            text: 'Age:',
                                            fontsize: 12,
                                          ),
                                          CustomTextWidget(
                                            text: passengers[i]['age']!,fontsize: 12,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomLabelText(
                                            text: 'Gender:',
                                            fontsize: 12,
                                          ),
                                          CustomTextWidget(
                                            text: passengers[i]['gender']!,fontsize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomLabelText(
                                            text: 'Mobile Number:',
                                            fontsize: 12,
                                          ),
                                          SizedBox(width: 4),
                                          CustomTextWidget(
                                            text: passengers[i]['mobile']!,fontsize: 12,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 16),
                                      Column(
                                        children: [
                                          CustomLabelText(
                                            text: 'Nationality:',
                                            fontsize: 12,
                                          ),
                                         
                                          CustomTextWidget(
                                            text: passengers[i]['nationality']!,fontsize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 16),
              CustomLabelText(
                text: 'Uploaded Documents',
                color: AppColors.btnBgColor,
                fontsize: 16,
              ),
              SizedBox(height: 8),
              ...documents.map(
                (doc) => Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: Icon(
                      Icons.insert_drive_file,
                      color: AppColors.btnBgColor,
                    ),
                    title: CustomTextWidget(text: doc['name']!),
                    subtitle: CustomTextWidget(
                      text: doc['size']!,
                      fontsize: 12,
                      color: Colors.grey,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.download, color: AppColors.btnBgColor),
                      onPressed: () {
                        // Download logic here
                        //print('Downloading ${doc['name']}');
                        CustomSnackbar.showSuccess(title: 'Download', message: 'Downloading ${doc['name']}');
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                   
                    backgroundColor: AppColors.btnBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                   Get.to(() => RailTicketForwordsPage());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.forward_rounded, color: Colors.white),
                      SizedBox(width: 8),
                      CustomTextWidget(text: 'Forward Ticket', color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
