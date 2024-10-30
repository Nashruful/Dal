import 'package:business_app/add_ads_screen/add_ads_screen.dart';
import 'package:business_app/screens/my_ads_screen/My_ads.dart';
import 'package:business_app/screens/stats_screen/stats_screen.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color(0xffA51361),
          foregroundColor: const Color(0xffF7F7F7),
          leadingWidth: 200,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/png/company_logo.png',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("Hello!".tr(),
                    style: Theme.of(context).textTheme.headlineMedium)
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 313,
                height: 190,
                decoration: BoxDecoration(
                  color: const Color(0xffF6B00E),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 130,
                              child: Text(
                                'title card'.tr(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 130,
                              child: Text(
                                'sub title card'.tr(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 8,
                      child: Image.asset('assets/png/ads_banner_image.png'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBusinessIconButton(
                      image: 'assets/svg/add_ads.svg',
                      title: 'home card label one'.tr(),
                      onPressed: () => const AddAdsScreen(),
                    ),
                    CustomBusinessIconButton(
                      image: 'assets/svg/view_stats.svg',
                      title: 'home card label two'.tr(),
                      onPressed: () => const StatsScreen(),
                    ),
                    CustomBusinessIconButton(
                      image: 'assets/svg/add_ads.svg',
                      title: 'home card label three'.tr(),
                      onPressed: () => const MyAdsScreen(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBusinessIconButton(
                        image: 'assets/svg/add_ads.svg',
                        title: 'home card label four'.tr()),
                    CustomBusinessIconButton(
                        image: 'assets/svg/view_stats.svg',
                        title: 'home card label five'.tr()),
                    CustomBusinessIconButton(
                        image: 'assets/svg/add_ads.svg',
                        title: 'home card label six'.tr()),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
