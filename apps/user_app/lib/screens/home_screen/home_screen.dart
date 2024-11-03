import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/customSnackbar/customSnackbar.dart';
import 'package:user_app/screens/home_screen/category_screen.dart';
import 'package:user_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:user_app/setup/setup.dart';
import 'package:dio/dio.dart';
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
            backgroundColor: Theme.of(context).primaryColor,
            leadingWidth: 200,
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
                  Text(
                    "Hello!".tr(),
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: IconButton(
                    onPressed: () {
                      //go to notifications?
                    },
                    icon: SvgPicture.asset('assets/svg/notification.svg')),
              ),
              TextButton(
                  onPressed: () async {
                    final dio = Dio();
                    try {
                      await dio.post(
                        "https://api.onesignal.com/api/v1/notifications",
                        data: {
                          "app_id": "ebdec5c2-30a4-447d-9577-a1c13b6d553e",
                          "contents": {
                            "en": "Check out Burger's king offer nearby!",
                            "ar": "لا يطوفك عرض Burger king!"
                          },
                          "include_external_user_ids": [
                            getIt.get<DataLayer>().supabase.auth.currentUser!.id
                          ], // Correct field name
                        },
                        options: Options(headers: {
                          "Authorization":
                              "Bearer ZGU5ZmExOTEtNmFiZC00ZTUxLTgyMGYtNjc4MDJlYjUyNmM4",
                          'Content-Type':
                              'application/json', // Ensure correct casing
                        }),
                      );
                    } on DioException catch (e) {
                      if (e.response != null) {}
                    } catch (e) {
                      null;
                    }
                  },
                  child: const Text(
                    "Send notification test",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w900),
                  ))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => cubit.refreshPage(),
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    width: 370,
                    height: 157,
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
                                child: Text(
                                  'title card'.tr(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 130,
                                  child: Text(
                                    'sub title card'.tr(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 8,
                          child: Image.asset(
                            'assets/png/29-Influencer 1.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          title: "Supermarket",
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
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Around you'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 250,
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
                                  getIt.get<DataLayer>().allAds.length),
                              children: getIt
                                  .get<DataLayer>()
                                  .nearbyBranches
                                  .map(
                                    (e) => ImpressionDetector(
                                      impressedCallback: () {
                                        getIt.get<DataLayer>().recordImpressions(
                                            e.id!); //add impressions to ad id each time it is viewed
                                      },
                                      child: CustomAdsContainer(
                                        companyLogo: e
                                                .branch!.business!.logoImg ??
                                            "https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg",
                                        remainingDay:
                                            "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                        companyName:
                                            e.branch!.business!.name ?? "----",
                                        offers: '${e.offerType!} ${'off'.tr()}',
                                        onTap: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return ImpressionDetector(
                                                  impressedCallback: () {
                                                    getIt
                                                        .get<DataLayer>()
                                                        .recordClicks(e
                                                            .id!); //add clicks to ad id each time it is viewed
                                                  },
                                                  child: CustomBottomSheet(
                                                    image: e.bannerimg!,
                                                    companyName: e.branch!
                                                            .business!.name ??
                                                        "---",
                                                    iconImage:
                                                        'assets/svg/coffee.svg',
                                                    description:
                                                        e.description ?? "---",
                                                    remainingDay: getIt
                                                        .get<DataLayer>()
                                                        .getRemainingTime(
                                                            e.enddate!),
                                                    onPressed: () {
                                                      try {
                                                        getIt
                                                            .get<DataLayer>()
                                                            .myReminders
                                                            .add(e.toJson());
                                                        CustomSnackbar.show(
                                                          context,
                                                          message:
                                                              'Reminder added successfully!',
                                                          isSuccess: true,
                                                        );
                                                      } catch (error) {
                                                        CustomSnackbar.show(
                                                          context,
                                                          message:
                                                              'Failed to add reminder!',
                                                          isSuccess: false,
                                                        );
                                                      }
                                                    },
                                                    offerType:
                                                        '40% ${'off'.tr()}',
                                                    viewLocation:
                                                        'View Location'.tr(),
                                                    locationOnPressed: () {},
                                                    button: ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            "EMPTY-- change this")),
                                                  ),
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
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Top'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 250,
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
                                  getIt.get<DataLayer>().allAds.length),
                              children: getIt
                                  .get<DataLayer>()
                                  .allAds
                                  .map(
                                    (e) => ImpressionDetector(
                                      impressedCallback: () {
                                        getIt.get<DataLayer>().recordImpressions(
                                            e.id!); //add impressions to ad id each time it is viewed
                                      },
                                      child: CustomAdsContainer(
                                        companyLogo: e
                                                .branch!.business!.logoImg ??
                                            "https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg",
                                        remainingDay:
                                            "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                        companyName:
                                            e.branch!.business!.name ?? "----",
                                        offers: '${e.offerType!} ${'off'.tr()}',
                                        onTap: () {
                                          String currentLogo =
                                              e.category!.toString();
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return ImpressionDetector(
                                                  impressedCallback: () {
                                                    getIt
                                                        .get<DataLayer>()
                                                        .recordClicks(e
                                                            .id!); //add clicks to ad id each time it is viewed
                                                  },
                                                  // child: CustomBottomSheet(
                                                  //   image: e.bannerimg!,
                                                  //   companyName: e.branch!
                                                  //           .business!.name ??
                                                  //       "---",
                                                  //   iconImage:
                                                  //       'assets/svg/$currentLogo.svg',
                                                  //   description:
                                                  //       e.description ?? "---",
                                                  //   remainingDay:
                                                  //       "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                                  //   onPressed: () {
                                                  //     getIt
                                                  //         .get<DataLayer>()
                                                  //         .myReminders
                                                  //         .add(e.toJson());
                                                  //   },
                                                  //   offerType:
                                                  //       '40% ${'off'.tr()}',
                                                  //   viewLocation:
                                                  //       'View Location'.tr(),
                                                  //   locationOnPressed: () {}, button: ElevatedButton(onPressed: (){}, child: Te),
                                                  // ),
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
