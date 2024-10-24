import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; 
final PreferredSizeWidget? bottom;
  CustomAppBar(
      {required this.title,  this.bottom}); 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white), 
      backgroundColor: Color(0xFFA51361), 
      bottom: bottom,
      title: Text(
        title,
        style: TextStyle(color: Colors.white), 
      ),
      
      centerTitle: true, 
    );
  } 
  
  @override
  Size get preferredSize => const Size.fromHeight(100);

}