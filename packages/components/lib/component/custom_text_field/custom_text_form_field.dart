import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final int? maxLines;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.fillColor,
      this.hintText,
      this.hintStyle,
      this.labelText,
      this.validator,
      this.maxLines, this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      validator: validator,
      controller: controller,
      maxLines: maxLines,
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
