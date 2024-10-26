import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/home_screen/cubit/home_cubit.dart';
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
              )
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: 370,
                  height: 157,
                  decoration: BoxDecoration(
                      color: const Color(0xffF6B00E),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: 0,
                                child: Text(
                                  'Never miss out',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Catch the latest deals and offers happening near you!',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Image.asset('assets/png/29-Influencer 1.png')
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
                        icon: 'assets/svg/coffee.svg',
                        title: 'Cafes'.tr(),
                        onPressed: () {},
                      ),
                      CustomIconButton(
                        icon: 'assets/svg/Bakery.svg',
                        title: 'Bakery'.tr(),
                        onPressed: () {
                          showModalBottomSheet(
                              isDismissible: true,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Stack(
                                  children: [
                                    FlutterMap(
                                      options: MapOptions(
                                          onTap: (tapPosition, point) {
                                            print(
                                                "${point.latitude},${point.longitude}");
                                          },
                                          initialCenter: const LatLng(
                                              24.826387045454805,
                                              46.763465973089424)),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.example.app',
                                        ),
                                        MarkerLayer(markers: [
                                          Marker(
                                              width: 100,
                                              height: 100,
                                              point: const LatLng(
                                                  24.826932334627926,
                                                  46.77479562383812),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            content:
                                                                CustomBottomSheet(
                                                              image:
                                                                  "https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/offer%20images/skrayz.png?t=2024-10-24T11%3A23%3A54.100Z",
                                                              companyName:
                                                                  "سكرايز",
                                                              iconImage:
                                                                  'assets/svg/coffee.svg',
                                                              description:
                                                                  "مع كل فاتورة امركيانو حار بـ 1 ريال سعودي 🍵",
                                                              remainingDay:
                                                                  '4d',
                                                              onPressed: () {},
                                                              offerType: '40',
                                                            ),
                                                          ));
                                                },
                                                child: const Icon(
                                                    color: Colors.blueAccent,
                                                    size: 35,
                                                    Icons.bakery_dining),
                                              )),
                                          const Marker(
                                              width: 100,
                                              height: 100,
                                              point: LatLng(24.825841754565865,
                                                  46.769989105435364),
                                              child: Icon(
                                                  color: Colors.blueAccent,
                                                  size: 35,
                                                  Icons.bakery_dining)),
                                          const Marker(
                                              width: 100,
                                              height: 100,
                                              point: LatLng(24.829035569055947,
                                                  46.77033242817841),
                                              child: Icon(
                                                  color: Colors.blueAccent,
                                                  size: 35,
                                                  Icons.bakery_dining)),
                                          const Marker(
                                              width: 100,
                                              height: 100,
                                              point: LatLng(24.819142266372218,
                                                  46.77299317943709),
                                              child: Icon(
                                                  color: Colors.blueAccent,
                                                  size: 35,
                                                  Icons.bakery_dining)),
                                        ]),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                              size: 40,
                                              color: Colors.red,
                                              Icons.close_rounded)),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      CustomIconButton(
                        icon: 'assets/svg/Breakfast.svg',
                        title: 'Breakfast'.tr(),
                        onPressed: () {},
                      ),
                      CustomIconButton(
                        icon: 'assets/svg/Ice_creams.svg',
                        title: 'Ice creams'.tr(),
                        onPressed: () {},
                      ),
                      CustomIconButton(
                        icon: 'assets/svg/Dinning.svg',
                        title: 'Dinning'.tr(),
                        onPressed: () {},
                      ),
                      CustomIconButton(
                        icon: 'assets/svg/Drinks.svg',
                        title: 'Drinks'.tr(),
                        onPressed: () {},
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
                            key: ValueKey(cubit.allAds!.length),
                            children: cubit.allAds!
                                .map(
                                  (e) => CustomAdsContainer(
                                    companyLogo: e['bannerimg'] ??
                                        "https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg",
                                    remainingDay: '4d',
                                    companyName: e['title'] ?? "----",
                                    offers: e['offer_type'] ?? "----",
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return CustomBottomSheet(
                                              image: e['bannerimg'],
                                              companyName: e['title'] ?? "---",
                                              iconImage:
                                                  'assets/svg/coffee.svg',
                                              description:
                                                  e['description'] ?? "---",
                                              remainingDay: '4d',
                                              onPressed: () {
                                                getIt
                                                    .get<DataLayer>()
                                                    .myReminders
                                                    .add(e);
                                              },
                                              offerType: '40',
                                            );
                                          });
                                    },
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
                            key: ValueKey(cubit.allAds!.length),
                            children: cubit.allAds!
                                .map(
                                  (e) => CustomAdsContainer(
                                    companyLogo: e['business']['logo_img'] ??
                                        "https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg",
                                    remainingDay: '4d',
                                    companyName: e['title'] ?? "----",
                                    offers: e['offer_type'] ?? "----",
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return CustomBottomSheet(
                                              image: e['bannerimg'],
                                              companyName: e['title'] ?? "---",
                                              iconImage:
                                                  'assets/svg/coffee.svg',
                                              description:
                                                  e['description'] ?? "---",
                                              remainingDay: '4d',
                                              onPressed: () {
                                                getIt
                                                    .get<DataLayer>()
                                                    .myReminders
                                                    .add(e);
                                              },
                                              offerType: '40',
                                            );
                                          });
                                    },
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
