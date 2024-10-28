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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<int>(
        value: value,
        hint: Text(
          'Select option',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        items: items,
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }
}
