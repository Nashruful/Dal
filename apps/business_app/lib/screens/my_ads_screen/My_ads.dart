import 'package:business_app/add_ads_screen/add_ads_screen.dart';
import 'package:business_app/screens/my_ads_screen/current_ads.dart';
import 'package:business_app/screens/my_ads_screen/custom_tabbar.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'past_ads.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; 

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "My Ads",
          bottom: MyAdsTabBar(),
        ),
        body: const TabBarView(
          children: [
            CurrentAdsTap(),
            PastAdsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddAdsScreen(),
            ));
          },
          backgroundColor: const Color(0xffA51361),
          child: const Icon(Icons.abc_outlined, color: Colors.white),
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
