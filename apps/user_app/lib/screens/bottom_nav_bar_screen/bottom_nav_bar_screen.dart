import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/screens/discover_screen/discover_screen.dart';
import 'package:user_app/screens/home_screen/home_screen.dart';
import 'package:user_app/screens/profile_screen/profile_screen.dart';
import 'package:user_app/screens/reminder_screen/reminder_screen.dart';

import 'bloc/nav_bar_bloc.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const HomeScreen(),
      const DiscoverScreen(),
      const ReminderScreen(),
      const ProfileScreen(),
    ];

    return BlocProvider(
      create: (context) => NavBarBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<NavBarBloc>();
        return BlocBuilder<NavBarBloc, NavBarState>(
          builder: (context, state) {
            return Scaffold(
              body: PageView(
                controller: bloc.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: bottomBarPages,
              ),
              extendBody: true,
              bottomNavigationBar: AnimatedNotchBottomBar(
                textOverflow: TextOverflow.fade,
                durationInMilliSeconds: 300,
                notchBottomBarController: bloc.notchBottomBarController,
                color: Theme.of(context).canvasColor,
                showLabel: true,
                maxLine: 1,
                shadowElevation: 5,
                kBottomRadius: 28.0,
                notchColor: AppColors().pink,
                bottomBarItems: [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home,
                      color: AppColors().grey2,
                    ),
                    activeItem: Icon(Icons.home, color: AppColors().white1),
                    itemLabel: 'Home'.tr(),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.location_on_rounded,
                        color: AppColors().grey2),
                    activeItem: Icon(Icons.location_on_rounded,
                        color: AppColors().white1),
                    itemLabel: 'Discover'.tr(),
                  ),
                  BottomBarItem(
                    inActiveItem:
                        Icon(Icons.notifications, color: AppColors().grey2),
                    activeItem:
                        Icon(Icons.notifications, color: AppColors().white1),
                    itemLabel: 'Reminder'.tr(),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.person, color: AppColors().grey2),
                    activeItem: Icon(Icons.person, color: AppColors().white1),
                    itemLabel: 'Profile'.tr(),
                  ),
                ],
                onTap: (index) {
                  bloc.pageController.jumpToPage(index);
                },
                kIconSize: 25,
              ),
            );
          },
        );
      }),
    );
  }
}
