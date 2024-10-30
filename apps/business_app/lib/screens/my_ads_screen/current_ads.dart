///////
///
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/my_ads_screen/cubit/my_ads_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntp/ntp.dart';
import 'package:flutter_svg/svg.dart';

///

class CurrentAdsTap extends StatelessWidget {
  const CurrentAdsTap({super.key});

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
    List currentAds = getIt.get<DataLayer>().allbusinessAds.where((ad) {
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
        itemCount: currentAds.length,
        itemBuilder: (context, index) {
          final ad = currentAds[index];
          return CustomAdsContainer(
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
                      iconImage: 'assets/svg/coffee.svg',
                      description: ad['description'] ?? "---",
                      remainingDay: getRemainingTime(ad['enddate']),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustemAlertDialog(
                                  title:
                                      'Are You Sure You Want To Delete This Ad?',
                                  msg: 'This will permanently delete the ad.',
                                  onPressed: () {
                                    cubit.deleteAd(ad['id']);
                                  },
                                  buttonLable: 'Delete Ad');
                            });
                      },
                      offerType: ad['offer_type'],
                      viewLocation: 'location',
                      buttonLable: 'Delete Ad',
                      locationOnPressed: () {},
                    );
                  });
            },
          );
        },
      ),
    );
  }
}

class CustemAlertDialog extends StatelessWidget {
  const CustemAlertDialog(
      {super.key,
      required this.title,
      required this.msg,
      required this.onPressed,
      required this.buttonLable});
  final String title;
  final String msg;
  final Function() onPressed;
  final String buttonLable;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset("assets/svg/confirm.svg"),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Column(
              children: [
                CustomElevatedButton(
                  onPressed: onPressed,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    buttonLable,
                    style: TextStyle(color: Color(0xffF7F7F7), fontSize: 14),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
