import 'package:business_app/add_ads_screen/add_ads_screen.dart';
import 'package:components/component/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_screen/home_screen.dart';
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
          AddAdsScreen(),
          Icon(
            Icons.notifications,
            size: 150,
          ),
          Icon(
            Icons.person,
            size: 150,
          ),
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
                label1: 'Home',
                label2: 'My Ads',
                label3: 'Stats',
                label4: 'Settings',
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
