import 'package:business_app/screens/home_screen/home_screen.dart';
import 'package:business_app/screens/my_ads_screen/My_ads.dart';
import 'package:business_app/screens/profile_screen/profile_screen.dart';
import 'package:business_app/screens/stats_screen/stats_screen.dart';
import 'package:components/component/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'bloc/nav_bar_bloc.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomBarPages = const [
      HomeScreen(),
      MyAdsScreen(),
      StatsScreen(),
      ProfileScreen(),
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
                    inActiveItem:
                        SvgPicture.asset('assets/svg/add_ads_icon.svg'),
                    activeItem: SvgPicture.asset('assets/svg/add_ads_icon.svg',
                        color: AppColors().white1),
                    itemLabel: 'My Ads'.tr(),
                  ),
                  BottomBarItem(
                    inActiveItem:
                        SvgPicture.asset("assets/svg/view_stats_icon.svg"),
                    activeItem: SvgPicture.asset(
                        "assets/svg/view_stats_icon.svg",
                        color: AppColors().white1),
                    itemLabel: 'Statistics'.tr(),
                  ),
                  BottomBarItem(
                    inActiveItem:
                        SvgPicture.asset('assets/svg/setting_icon.svg'),
                    activeItem: SvgPicture.asset('assets/svg/setting_icon.svg',
                        color: AppColors().white1),
                    itemLabel: 'Settings'.tr(),
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
