import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/my_ads_screen/cubit/my_ads_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentAdsTap extends StatelessWidget {
  const CurrentAdsTap({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyAdsCubit>();
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;
    return BlocBuilder<MyAdsCubit, MyAdsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: cubit.currentAds.isEmpty
              ? const Center(
                  child: Text('There is no current ads!'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: cubit.currentAds.length,
                  itemBuilder: (context, index) {
                    final ad = cubit.currentAds[index];
                    return CustomAdsContainer(
                      companyName: getIt.get<DataLayer>().currentBusinessInfo[0]
                          ['name'],
                      companyLogo: ad['bannerimg'] ??
                          "https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/offer%20images/DalLogo.png",
                      remainingDay:
                          '${cubit.getRemainingTime(ad['enddate'])} d',
                      offers: ad['offer_type'],
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return CustomBottomSheet(
                                image: ad['bannerimg'],
                                companyName: getIt
                                        .get<DataLayer>()
                                        .currentBusinessInfo[0]['name'] ??
                                    "---",
                                iconImage: 'assets/svg/coffee.svg',
                                description: ad['description'] ?? "---",
                                remainingDay:
                                    cubit.getRemainingTime(ad['enddate']),
                                offerType: ad['offer_type'],
                                views: ad['views'],
                                clicks: ad['clicks'],
                                button: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomAlertDialog(
                                              title: 'Delete Ads title'.tr(),
                                              msg: 'Delete Ads subtitle'.tr(),
                                              onPressed: () {
                                                cubit.deleteAd(ad['id']);
                                                Navigator.pop(context, true);
                                              },
                                              buttonLabel:
                                                  'Confirm button'.tr(),
                                              cancelLable: 'Cancel Button'.tr(),
                                            );
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff8CBFAE)),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Delete Ad'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ],
                                    )),
                              );
                            });
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
