
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/responsive_states_card.dart';
import 'package:flutter/material.dart';

class ApplicationDetails extends StatefulWidget {
  const ApplicationDetails({super.key});

  @override
  State<ApplicationDetails> createState() => _ApplicationDetailsState();
}

class _ApplicationDetailsState extends State<ApplicationDetails> {
  @override
  Widget build(BuildContext context) {
    
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      verticalDirection: VerticalDirection.down,
       spacing: 16,
      runSpacing: 16,
      children: [
        CustomTextWidget(text: 'Hi Admin', fontWeight: FontWeight.bold, fontsize: 16,),
        ResponsiveStatCard(icon: Icons.calculate, title:"Total Application", count: '100'),
        ResponsiveStatCard(icon: Icons.pending, title:"Pending Application", count: '30'),
        ResponsiveStatCard(icon: Icons.home, title:"Success Application", count: '40'),
        ResponsiveStatCard(icon: Icons.home, title:"Rejected Application", count: '30'),
      ],
    );
  }
}
