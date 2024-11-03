import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final double height;
  final bool automaticallyImplyLeading;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.bottom,
      required this.automaticallyImplyLeading,
      this.height = 50});
//
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: const IconThemeData(color: Colors.white),
      bottom: bottom,
      backgroundColor: const Color(0xFFA51361),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
