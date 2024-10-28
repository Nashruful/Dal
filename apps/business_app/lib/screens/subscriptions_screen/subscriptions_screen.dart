import 'package:components/component/custom_cards/subscriptions_card.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            child:
                                SvgPicture.asset('assets/svg/Objectives.svg'))),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'title plan'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('sub title plan'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSubscriptionsCard(
                          duration: 'subscription one month'.tr(),
                          price: 100,
                          plan: 'Basic'.tr(),
                          selected: true,
                          onTap: () {},
                          currency: 'SAR'.tr(),
                        ),
                        CustomSubscriptionsCard(
                            duration: 'subscription two month'.tr(),
                            price: 250,
                            plan: 'Standard'.tr(),
                            selected: false,
                            onTap: () {},
                            currency: 'SAR'.tr()),
                        CustomSubscriptionsCard(
                            duration: 'subscription three month'.tr(),
                            price: 500,
                            plan: 'Enterprise'.tr(),
                            selected: false,
                            onTap: () {},
                            currency: 'SAR'.tr())
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Basic description'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(
                      height: 15,
                    ),
                    1 == 1 //if used free plan
                        ? CustomElevatedButton(
                            onPressed: () {
                              //
                            },
                            backgroundColor: AppColors().green,
                            child: Text('free Trial button'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium),
                          )
                        : SizedBox(),
                    CustomElevatedButton(
                      onPressed: () {
                        //
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        'choose Plan button'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
