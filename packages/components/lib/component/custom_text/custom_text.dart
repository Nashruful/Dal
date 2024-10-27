import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key,
      required this.text,
      required this.color,
      this.fontWeight,
      required this.fontSize, this.textAlign});
  final String text;
  final Color color;
  final FontWeight? fontWeight;
  final double fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(textAlign: textAlign, 
      text,
      style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}