import 'package:flutter/material.dart';

class CustomDrobDownButton extends StatelessWidget {
  const CustomDrobDownButton(
      {super.key, this.value, required this.items, this.onChanged});
  final int? value;
  final List<DropdownMenuItem<int>> items;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffEAEAEA),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<int>(
        dropdownColor: const Color(0xffEAEAEA),
        value: value,
        hint: const Text('Select option'),
        items: items,
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }
}
