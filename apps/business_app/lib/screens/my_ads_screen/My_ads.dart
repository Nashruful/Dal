import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'current_ads.dart';
import 'custom_tabbar.dart';
import 'past_ads.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "My Ads",
          bottom: MyAdsTabBar(),
          automaticallyImplyLeading: false,
        ),
        body: const TabBarView(
          children: [
            CurrentAdsTap(),
            PastAdsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xffA51361),
          child: Icon(Icons.add, color: Colors.white),
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
