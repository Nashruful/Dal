import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? child;
  final void Function()? onPressed;
  final Color? backgroundColor;
  const CustomElevatedButton(
      {super.key, this.child, this.onPressed, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(53),
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(31))),
      child: Center(child: child),
    );
  }
}
