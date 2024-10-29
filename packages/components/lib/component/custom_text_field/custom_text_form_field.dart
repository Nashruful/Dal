import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
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
      this.maxLines,
      this.autovalidateMode,
      this.maxLength,
      this.minLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      maxLength: maxLength,
      minLines: minLines,
      onChanged: (text) {
        final lines = text.split('\n');
        if (lines.length > maxLines!) {
          controller?.text = lines.take(maxLines!).join('\n');
          controller?.selection = TextSelection.fromPosition(
            TextPosition(offset: controller!.text.length),
          );
        }
      },
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
