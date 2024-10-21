import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_cintainers/custom_ads_container.dart';
import 'package:components/component/custom_text/custom_text.dart';

import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});
//
/////
//////////
//////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Reminder"),
      body: const SingleChildScrollView(
          child: SizedBox(
            child: Column(
                    children: [
            Row(
                     
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomAdsContainer(
                    companyName: 'Half Millon',
                    ComapanyLogo: 'assets/png/company_logo.png',
                    remainingDay: '4d',
                    offers: '50% off'),
                CustomAdsContainer(
                    companyName: 'Half Millon',
                    ComapanyLogo: 'assets/png/company_logo.png',
                    remainingDay: '4d',
                    offers: '50% off'),
              ],
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomAdsContainer(
                      companyName: 'Half Millon',
                      ComapanyLogo: 'assets/png/company_logo.png',
                      remainingDay: '4d',
                      offers: '50% off'),
                  CustomAdsContainer(
                    companyName: 'Half Millon',
                    ComapanyLogo: 'assets/png/company_logo.png',
                    remainingDay: '4d',
                    offers: '50% off',
                  ),
                ],
              ),
            ),
                    ],
                  ),
          )),
    );
  }
}
