import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:flutter/material.dart';


class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String? label;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.label,  
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label?,
        //   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        // ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          //padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            
            color: const Color(0xFFF5F6FA),

            borderRadius: BorderRadius.circular(8),
            
           // border: Border.all(color: AppColors.textGrey),
          ),
          child: DropdownButtonHideUnderline(
            
            child: DropdownButton<String>(
             
              borderRadius: BorderRadius.circular(20),
              value: selectedValue,
              hint: Text('Select type',style: TextStyle(fontFamily: 'Poppins',fontSize: 12,color: AppColors.textGrey),),
            isExpanded: true,
            dropdownColor: AppColors.bgLight,
            enableFeedback: true,
              icon: const Icon(Icons.arrow_drop_down,size: 40,color: AppColors.btnBgColor,),
              // dropdownColor: Colors.white.withOpacity(0.95), // Transparent-style
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  
                  value: value,
                  child: Text(value,style: TextStyle(color: AppColors.textGrey,fontSize: 13,fontFamily: 'Poppins',fontWeight: FontWeight.w500,),),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
