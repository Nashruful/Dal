
import 'package:components/components.dart';
import 'package:flutter/material.dart';


class CurrentAdsTap extends StatelessWidget {
  const CurrentAdsTap({super.key});
////
  @override
  Widget build(BuildContext context) {
    return const Scaffold(  body: SingleChildScrollView(
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
           )],))));
  }
}