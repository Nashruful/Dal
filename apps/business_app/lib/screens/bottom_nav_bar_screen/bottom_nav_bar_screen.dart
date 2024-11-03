import 'package:business_app/screens/home_screen/home_screen.dart';
import 'package:business_app/screens/my_ads_screen/My_ads.dart';
import 'package:business_app/screens/profile_screen/profile_screen.dart';
import 'package:business_app/screens/stats_screen/stats_screen.dart';
import 'package:components/component/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_ads_screen/My_ads.dart';
import 'bloc/nav_bar_bloc.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarBloc(),
      child: Builder(builder: (context) {
        int index = 0;
        List navBarPages = const [
          HomeScreen(),
          MyAdsScreen(),
          StatsScreen(),
          ProfileScreen(),
        ];
        return BlocBuilder<NavBarBloc, NavBarState>(
          builder: (context, state) {
            if (state is BottomNavBarState) {
              index = state.index;
            }
            return Scaffold(
              bottomNavigationBar: CustomBottomNavBar(
                index: index,
                icons1: 'assets/svg/home.svg',
                icons2: 'assets/svg/add_ads_icon.svg',
                icons3: 'assets/svg/view_stats_icon.svg',
                icons4: 'assets/svg/setting_icon.svg',
                label1: 'Home'.tr(),
                label2: 'My Ads'.tr(),
                label3: 'Statistics'.tr(),
                label4: 'Settings'.tr(),
                onTap: (value) {
                  context
                      .read<NavBarBloc>()
                      .add(BottomNavBarEvent(index: value));
                },
              ),
              body: Center(
                child: navBarPages[index],
              ),
            );
          },
        );
      }),
    );
  }
}
