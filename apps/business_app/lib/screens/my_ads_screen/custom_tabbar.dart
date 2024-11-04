import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyAdsTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAdsTabBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors().white1,
      child: TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors().pink,
            width: 3.0,
          ),
          insets: const EdgeInsets.symmetric(horizontal: -80.0),
          insets: const EdgeInsets.symmetric(horizontal: -80.0),
        ),
        labelColor: AppColors().pink,
        unselectedLabelColor: AppColors().grey2,
        labelStyle: const TextStyle(
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          Tab(text: "current Ads".tr()),
          Tab(text: "past Ads".tr()),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
