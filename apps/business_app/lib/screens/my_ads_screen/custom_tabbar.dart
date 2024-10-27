import 'package:flutter/material.dart';

class MyAdsTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Color(0xffA51361),
            width: 3.0,
          ),
          insets: EdgeInsets.symmetric(horizontal: -80.0),
        ),
        labelColor: Color(0xffA51361),
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          Tab(text: "Current"),
          Tab(text: "Past"),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
