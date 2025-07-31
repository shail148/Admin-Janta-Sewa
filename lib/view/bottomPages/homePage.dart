import 'package:admin_jantasewa/components/application_chart.dart';
import 'package:admin_jantasewa/components/application_details.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CustomTextWidget(text: 'Application Details: ', fontWeight: FontWeight.bold,fontsize: 14,),
            SizedBox(height: 10,),
            //Application Details Component Use
             ApplicationDetails(),
             //Chart
             PieChartSample2()
             
          ],
        ),
      ),
    );
  }
}