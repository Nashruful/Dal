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
    String getRemainingTime(String dateString) {
      //parse targettime
      DateTime targetDate = DateTime.parse(dateString);

// Calculate the difference
      Duration difference = targetDate.difference(DateTime.now());

// Get the remaining days
      int remainingDays = difference.inDays;
      if (remainingDays < 0) {
        remainingDays = 0;
      }
      return remainingDays.toString();
    }

//get past ads only
    List liveAds = getIt.get<DataLayer>().allbusinessAds.where((ad) {
      DateTime endDate = DateTime.parse(ad['enddate']);
      return endDate.isBefore(DateTime.now());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2 / 3,
        ),
        itemCount: liveAds.length,
        itemBuilder: (context, index) {
          final ad = liveAds[index];
          return CustomAdsContainer(
            opacity: 0.3,
            companyName: getIt.get<DataLayer>().currentBusinessInfo[0]['name'],
            companyLogo: ad['bannerimg'],
            remainingDay: '${getRemainingTime(ad['enddate'])} d',
            offers: ad['offer_type'],
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(
                      image: ad['bannerimg'],
                      companyName: getIt.get<DataLayer>().currentBusinessInfo[0]
                              ['name'] ??
                          "---",
                      description: ad['description'] ?? "---",
                      remainingDay: getRemainingTime(ad['enddate']),
                      offerType: ad['offer_type'],
                      viewLocation: 'location',
                      locationOnPressed: () {
                        //
                      },
                      views: ad['views'],
                      clicks: ad['clicks'],
                      button: ElevatedButton(
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors().green),
                          child: Row(
                            children: [
                              Text(
                                'Delete Ad',
                                style: Theme.of(context).textTheme.labelSmall,
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
  }
}
