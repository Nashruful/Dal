import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(
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
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<int>(
        dropdownColor: Theme.of(context).canvasColor,
        value: value,
        hint: const Text('Select option'),
        style: Theme.of(context).textTheme.bodyMedium,
        items: items,
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }
}
