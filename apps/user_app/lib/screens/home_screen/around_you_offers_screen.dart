import 'package:components/component/custom_bottom_sheets/custom_bottom_sheet.dart';
import 'package:components/component/custom_containers/custom_ads_container.dart';
import 'package:components/component/shimmer_custom/shimmer_container.dart';
import 'package:components/component/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:impression/impression.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:user_app/screens/home_screen/home_screen.dart';
import 'package:user_app/setup/setup.dart';

class AroundYouOffersScreen extends StatelessWidget {
  const AroundYouOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SizedBox(
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
                  key: ValueKey(getIt.get<DataLayer>().liveAds.length),
                  children: getIt.get<DataLayer>().nearbyBranches.isEmpty
                      ? [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 40),
                            child: Container(
                                width: MediaQuery.of(context).size.width - 48,
                                decoration: BoxDecoration(
                                  color: AppColors().yellow,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('place holder'.tr(),
                                      style:
                                          TextStyle(color: AppColors().black1)),
                                )),
                          )
                        ]
                      : getIt
                          .get<DataLayer>()
                          .nearbyBranches
                          .map(
                            (e) => ImpressionDetector(
                              impressedCallback: () {
                                getIt.get<DataLayer>().recordImpressions(e
                                    .id!); //add impressions to ad id each time it is viewed
                              },
                              child: CustomAdsContainer(
                                companyLogo: e.branch!.business!.logoImg ??
                                    "https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/user%20profile%20images/images/defualt_profile_img.png?t=2024-11-03T13%3A11%3A13.024Z",
                                remainingDay:
                                    "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                companyName: e.branch!.business!.name ?? "----",
                                offers: '${e.offerType!} ${'off'.tr()}',
                                onTap: () {
                                  getIt.get<DataLayer>().recordClicks(e.id!);
                                  String currentLogo = e.category!.toString();
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return BlocProvider(
                                          create: (context) => HomeCubit(),
                                          child: CustomBottomSheet(
                                            image: e.bannerimg!,
                                            companyName:
                                                e.branch!.business!.name ??
                                                    "---",
                                            iconImage:
                                                'assets/svg/$currentLogo.svg',
                                            description: e.description ?? "---",
                                            remainingDay:
                                                "${getIt.get<DataLayer>().getRemainingTime(e.enddate!)}d",
                                            offerType: e.offerType!,
                                            textButton: TextButton(
                                                onPressed: () async {
                                                  final availableMaps =
                                                      await MapLauncher
                                                          .installedMaps;

                                                  if (availableMaps
                                                      .isNotEmpty) {
                                                    await availableMaps.first
                                                        .showMarker(
                                                      coords: Coords(
                                                          e.branch!.latitude!,
                                                          e.branch!.longitude!),
                                                      title: e.branch!.business!
                                                          .name!,
                                                    );
                                                  } else {
                                                    // Handle the case where no maps are installed

                                                    ScaffoldMessenger.of(
                                                            // ignore: use_build_context_synchronously
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              'No maps are installed on this device.'
                                                                  .tr())),
                                                    );
                                                  }
                                                  //
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svg/discover.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                              BlendMode.srcIn),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'View Location'.tr(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ],
                                                )),
                                            button: cubit.returnButton(e),
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
                child: Center(child: Text("error fetching data..")));
          },
        ),
      ),
    );
  }
}
