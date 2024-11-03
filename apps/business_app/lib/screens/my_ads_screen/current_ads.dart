///////
///
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/my_ads_screen/cubit/my_ads_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///

class CurrentAds extends StatelessWidget {
  const CurrentAds({super.key});

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

//get current ads only
    List liveAds = getIt.get<DataLayer>().allbusinessAds.where((ad) {
      DateTime endDate = DateTime.parse(ad['enddate']);
      return endDate.isAfter(DateTime.now());
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
            companyName: getIt.get<DataLayer>().currentBusinessInfo[0]['name'],
            companyLogo: ad['bannerimg'] ??
                "https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/offer%20images/DalLogo.png",
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
