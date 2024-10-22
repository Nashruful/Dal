import 'package:components/component/custom_cintainers/custom_ads_container.dart';
import 'package:components/component/custom_text/custom_text.dart';

import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA51361),
        foregroundColor: const Color(0xffF7F7F7),
        centerTitle: true,
        title: const CustomText(
          text: "My Reminder",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xfff7f7f7),
        ),
      ),
      body: SingleChildScrollView(
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
