import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/home_screen/around_you_offers_screen.dart';
import 'package:user_app/screens/home_screen/category_screen.dart';
import 'package:user_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:user_app/screens/home_screen/latest_offers_section.dart';
import 'package:user_app/setup/setup.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        cubit.getAllAds();
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors().pink,
            leadingWidth: 300,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/png/profile.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Hello".tr(),
                        style:
                            TextStyle(fontSize: 24, color: AppColors().white1),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => cubit.refreshPage(),
            child: ListView(
              children: [
                //====================Hero Element
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Container(
                    width: double.infinity,
                    height: 183,
                    decoration: BoxDecoration(
                      color: AppColors().yellow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 150,
                                  child: Text(
                                    'title card'.tr(),
                                    style: TextStyle(
                                        color: AppColors().white1,
                                        fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 120,
                                  child: Text(
                                    'sub title card'.tr(),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/png/29-Influencer 1.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //====================Filters Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            icon: 'assets/svg/Dining.svg',
                            title: 'Dining'.tr(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                          categoryList: getIt
                                              .get<DataLayer>()
                                              .diningCategory)));
                            },
                          ),
                          CustomIconButton(
                            icon: 'assets/svg/Supermarkets.svg',
                            title: "Grocery".tr(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                          categoryList: getIt
                                              .get<DataLayer>()
                                              .superMarketsCategory)));
                            },
                          ),
                          CustomIconButton(
                            icon: 'assets/svg/Fashion.svg',
                            title: "Fashion".tr(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                          categoryList: getIt
                                              .get<DataLayer>()
                                              .fashionCategory)));
                            },
                          ),
                          CustomIconButton(
                            icon: 'assets/svg/Hotels.svg',
                            title: "Hotels".tr(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                          categoryList: getIt
                                              .get<DataLayer>()
                                              .hotelsCategory)));
                            },
                          ),
                          CustomIconButton(
                            icon: 'assets/svg/Gym.svg',
                            title: "Gym".tr(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                          categoryList: getIt
                                              .get<DataLayer>()
                                              .gymCategory)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                //=================== Around you section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Around you'.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      Tooltip(
                        message: 'TooltipInfo'.tr(),
                        child: Icon(
                          Icons.info,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const AroundYouOffersScreen(),
                const SizedBox(
                  height: 20,
                ),
                //===============Latest
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Latest Offers'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const LatestOffersSection(),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class FadeTransitionSwitcher extends StatelessWidget {
  final Widget child;

  const FadeTransitionSwitcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}
