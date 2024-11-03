import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/add_ads_screen/add_ads_screen.dart';
import 'package:business_app/screens/stats_screen/stats_screen.dart';
import 'package:business_app/screens/subscriptions_screen/subscriptions_screen.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String planEndDate =
        getIt.get<DataLayer>().latestSubscription['end_date'] ?? '';
    DateTime currentDate = DateTime.now();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: AppColors().pink,
          leadingWidth: 200,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      getIt.get<DataLayer>().currentBusinessInfo[0]['logo_img'],
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("Hello!".tr(),
                    style: TextStyle(color: AppColors().white1, fontSize: 24))
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xffF6B00E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 250,
                                  child: Text(
                                      'Ship Your Brand into the Spotlight!',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: AppColors().white1,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    ' Elevate your marketing and let users know about your exciting offers!',
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
                          //   top: 0,
                          bottom: 0,
                          child: Image.asset('assets/png/ads_banner_image.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width / 1.8,
                        decoration: BoxDecoration(
                            color: AppColors().pink,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                  color: AppColors().black1.withOpacity(0.25))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Know Your Statistics',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors().white1,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'See how many clicks and views your ads are generating.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: AppColors().yellow,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const StatsScreen()));
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: AppColors().pink,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            color: AppColors().white1,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                  color: AppColors().black1.withOpacity(0.25))
                            ]),
                        child: SvgPicture.asset('assets/svg/home_card.svg'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            color: AppColors().white1,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                  color: AppColors().black1.withOpacity(0.25))
                            ]),
                        child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/svg/home_card2.svg',
                            )),
                      ),
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width / 1.8,
                        decoration: BoxDecoration(
                            color: AppColors().pink,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                  color: AppColors().black1.withOpacity(0.25))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Your Ads',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors().white1,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Post your ads and get them in front of local audiences!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: AppColors().yellow,
                                      child: IconButton(
                                          onPressed: () {
                                            planEndDate == '' ||
                                                    DateTime.parse(planEndDate)
                                                        .isBefore(currentDate)
                                                ? () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AddAdsScreen(),
                                                      ),
                                                    );
                                                  }
                                                : Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SubscriptionsScreen()));
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: AppColors().pink,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
