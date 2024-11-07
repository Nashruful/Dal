import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key,
      this.controller,
      this.fillColor,
      this.hintText,
      this.hintStyle,
      this.labelText, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
