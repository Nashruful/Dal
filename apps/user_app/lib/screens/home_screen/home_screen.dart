import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/home_screen/category_screen.dart';
import 'package:user_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:user_app/setup/setup.dart';
import 'package:impression/impression.dart';

//
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
                      // Text(
                      //   ' ${getIt.get<DataLayer>().currentUserInfo!['first_name'] ?? ''}!',
                      //   style:
                      //       TextStyle(fontSize: 24, color: AppColors().white1),
                      // ),
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
                    height: 180,
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
                                width: 8,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 150,
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
                            title: 'Dining',
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
                            title: "Market",
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
                            title: "Fashion",
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
                            title: "Hotels",
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
                            title: "Gym",
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

                //===================Around you secrion
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
                        message: 'View Offers Available Within 1 Km',
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
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const FadeTransitionSwitcher(
                            child: Row(
                              children: [
                                ShimmerContainer(height: 230, width: 160),
                                SizedBox(
                                  width: 20,
                                ),
                                ShimmerContainer(height: 230, width: 160),
                                SizedBox(
                                  width: 20,
                                ),
                                ShimmerContainer(height: 230, width: 160),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          );
                        }
                        if (state is SuccessState) {
                          return FadeTransitionSwitcher(
                            child: Row(
                              key: ValueKey(
                                  getIt.get<DataLayer>().liveAds.length),
                              children: getIt
                                      .get<DataLayer>()
                                      .nearbyBranches
                                      .isEmpty
                                  ? [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 40),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                48,
                                            decoration: BoxDecoration(
                                              color: AppColors().yellow,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Nothing Around You At The Moment...\nTry Somewhere Else',
                                                    style: TextStyle(
                                                        color: AppColors()
                                                            .black1)),
                                              ),
                                            )),
                                      )
                                    ]
                                  : getIt
                                      .get<DataLayer>()
                                      .nearbyBranches
                                      .map(
                                        (e) => ImpressionDetector(
                                          impressedCallback: () {
                                            getIt
                                                .get<DataLayer>()
                                                .recordImpressions(e
                                                    .id!); //add impressions to ad id each time it is viewed
                                          },
                                          child: CustomAdsContainer(
                                            companyLogo: e.branch!.business!
                                                    .logoImg ??
                                                "https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/user%20profile%20images/images/defualt_profile_img.png?t=2024-11-03T13%3A11%3A13.024Z",
                                            remainingDay:
                                                "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                            companyName:
                                                e.branch!.business!.name ??
                                                    "----",
                                            offers:
                                                '${e.offerType!} ${'off'.tr()}',
                                            onTap: () {
                                              getIt
                                                  .get<DataLayer>()
                                                  .recordClicks(e.id!);
                                              String currentLogo =
                                                  e.category!.toString();
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return CustomBottomSheet(
                                                      image: e.bannerimg!,
                                                      companyName: e.branch!
                                                              .business!.name ??
                                                          "---",
                                                      iconImage:
                                                          'assets/svg/$currentLogo.svg',
                                                      description:
                                                          e.description ??
                                                              "---",
                                                      remainingDay:
                                                          "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                                      offerType: e.offerType!,
                                                      viewLocation:
                                                          'View Location'.tr(),
                                                      locationOnPressed: () {
                                                        //
                                                      },
                                                      button:
                                                          cubit.returnButton(e),
                                                      buttonLable: 'Remind me',
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          );
                        }
                        return const SizedBox(
                            height: 100,
                            width: 100,
                            child: Text("error fetching data.."));
                      },
                    ),
                  ),
                ),
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
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const FadeTransitionSwitcher(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ShimmerContainer(height: 200, width: 160),
                                ShimmerContainer(height: 200, width: 160),
                                ShimmerContainer(height: 200, width: 160),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          );
                        }
                        if (state is SuccessState) {
                          return FadeTransitionSwitcher(
                            child: Row(
                              key: ValueKey(
                                  getIt.get<DataLayer>().liveAds.length),
                              children: getIt
                                  .get<DataLayer>()
                                  .liveAds
                                  .map(
                                    (e) => ImpressionDetector(
                                      impressedCallback: () {
                                        getIt.get<DataLayer>().recordImpressions(
                                            e.id!); //add impressions to ad id each time it is viewed
                                      },
                                      child: CustomAdsContainer(
                                        companyLogo: e
                                                .branch!.business!.logoImg ??
                                            "https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/user%20profile%20images/images/defualt_profile_img.png?t=2024-11-03T13%3A11%3A13.024Z",
                                        remainingDay:
                                            "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                        companyName:
                                            e.branch!.business!.name ?? "----",
                                        offers: '${e.offerType!} ${'off'.tr()}',
                                        onTap: () {
                                          getIt
                                              .get<DataLayer>()
                                              .recordClicks(e.id!);
                                          String currentLogo =
                                              e.category!.toString();
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return CustomBottomSheet(
                                                  image: e.bannerimg!,
                                                  companyName: e.branch!
                                                          .business!.name ??
                                                      "---",
                                                  iconImage:
                                                      'assets/svg/$currentLogo.svg',
                                                  description:
                                                      e.description ?? "---",
                                                  remainingDay:
                                                      "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                                  offerType: e.offerType!,
                                                  viewLocation:
                                                      'View Location'.tr(),
                                                  locationOnPressed: () {
                                                    //
                                                  },
                                                  button: cubit.returnButton(e),
                                                  buttonLable: '',
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        }
                        return const SizedBox(
                            height: 100,
                            width: 100,
                            child: Text("error fetching data.."));
                      },
                    ),
                  ),
                ),
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
