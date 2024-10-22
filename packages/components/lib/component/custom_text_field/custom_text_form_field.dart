import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../custom_text/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? Function(String?)? validator;
  final String? title;
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.fillColor,
      this.hintText,
      this.hintStyle,
      this.labelText,
      this.validator,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title ?? "null",
          color: const Color(0xff444444),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              hintStyle: hintStyle,
              labelStyle: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: fillColor),
        ),
      ],
    );
  }
}
