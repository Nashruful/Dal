

import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'current_ads.dart';
import 'past_ads.dart';


class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      appBar: CustomAppBar(title: "My Ads"),
        body: const TabBarView(
          children: [
            CurrentAdsTap(),
            PastAdsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xffA51361),
          child:  Icon(Icons.abc_outlined, color: Colors.white),
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}