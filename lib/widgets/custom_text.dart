import 'package:flutter/material.dart';

//custome text widget
class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const CustomTextWidget( {
    super.key,
    required this.text,
    this.fontsize = 14,
    this.color = Colors.black,
    this.fontWeight,
    this.textAlign,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontsize,
        color: color,
        fontFamily: 'Poppins',
        fontWeight: fontWeight,
      ),
    );
  }
}
