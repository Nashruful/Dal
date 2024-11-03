import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/my_ads_screen/cubit/my_ads_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PastAdsTab extends StatelessWidget {
  const PastAdsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyAdsCubit>();
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: cubit.pastAds.isEmpty
          ? const Center(
              child: Text("There is no past ads"),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2 / 3,
              ),
              itemCount: cubit.pastAds.length,
              itemBuilder: (context, index) {
                final ad = cubit.pastAds[index];
                return CustomAdsContainer(
                  opacity: 0.3,
                  companyName: getIt.get<DataLayer>().currentBusinessInfo[0]
                      ['name'],
                  companyLogo: ad['bannerimg'],
                  remainingDay: '${cubit.getRemainingTime(ad['enddate'])} d',
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
                            // iconImage: 'assets/svg/coffee.svg',
                            description: ad['description'] ?? "---",
                            remainingDay: cubit.getRemainingTime(ad['enddate']),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustemAlertDialog(
                                        title:
                                            'Are You Sure You Want To Delete This Ad?',
                                        msg:
                                            'This will permanently delete the ad.',
                                        onPressed: () {
                                          cubit.deleteAd(ad['id']);
                                        },
                                        buttonLable: 'Delete Ad');
                                  });
                            },
                            views: ad['views'],
                            clicks: ad['clicks'],
                            offerType: ad['offer_type'],
                            viewLocation: 'location',
                            buttonLable: 'Delete Ad',
                            locationOnPressed: () {},
                            button: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors().green),
                              onPressed: () {
                                cubit.deleteAd(ad['id']);
                              },
                              child: Text(
                                'Delete Ad',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          );
                        });
                  },
                );
              },
            ),
    );
  }
}
