import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/payment_screen/payment_screen.dart';
import 'package:business_app/screens/subscriptions_screen/bloc/subscriptions_screen_bloc_bloc.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => SubscriptionBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<SubscriptionBloc>();
          DateTime currentDate = DateTime.now();

          DateTime datePlus30Days = currentDate.add(const Duration(days: 30));

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const CustomAppBar(
                title: 'Subscription Plan', automaticallyImplyLeading: true),
            body: BlocListener<SubscriptionBloc, SubscriptionState>(
              listener: (BuildContext context, state) {
                if (state is loadingState) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Lottie.asset(
                              height: 70, 'assets/json/loading.json')));
                }
                if (state is SubscriptionConfirmedState) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: const Text('Successefully Activatied Plan')));
                }
                if (state is SubscriptionErrorState) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const CustemErrorDialog(msg: '');
                      });
                }
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      child: SvgPicture.asset(
                                          'assets/svg/Objective.svg'))),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'title plan'.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text('sub title plan'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<SubscriptionBloc, SubscriptionState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomSubscriptionsCard(
                                      duration: 'subscription one month'.tr(),
                                      price: 100,
                                      plan: 'Basic'.tr(),
                                      selected: bloc.selectedPlan[0]!,
                                      onTap: () {
                                        bloc.add(TabCardEvent(index: 0));
                                      },
                                      currency: 'SAR'.tr(),
                                    ),
                                    CustomSubscriptionsCard(
                                        duration: 'subscription two month'.tr(),
                                        price: 250,
                                        plan: 'Standard'.tr(),
                                        selected: bloc.selectedPlan[1]!,
                                        onTap: () {
                                          bloc.add(TabCardEvent(index: 1));
                                        },
                                        currency: 'SAR'.tr()),
                                    CustomSubscriptionsCard(
                                        duration:
                                            'subscription three month'.tr(),
                                        price: 500,
                                        plan: 'Enterprise'.tr(),
                                        selected: bloc.selectedPlan[2]!,
                                        onTap: () {
                                          bloc.add(TabCardEvent(index: 2));
                                        },
                                        currency: 'SAR'.tr())
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<SubscriptionBloc, SubscriptionState>(
                              builder: (context, state) {
                                return Text(bloc.planDesc,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium);
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                //

                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          )),
                                      height: 700,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 50, 20, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Payment Confirmation",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                                Text(
                                                  "By confirming your payment, your ${bloc.planType} subscription will begin on ${currentDate.day}/${currentDate.month}/${currentDate.year} and last until ${datePlus30Days.day}/${datePlus30Days.month}/${datePlus30Days.year}.",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          PaymentScreen(
                                            totalPrice: bloc.planPrice,
                                            planType: bloc.planType,
                                            startDate: currentDate,
                                            endDate: datePlus30Days,
                                            paymentFunc: () {
                                              bloc.add(confirmSubscription(
                                                  isFreeTrial: false,
                                                  start: currentDate,
                                                  end: datePlus30Days));
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                'choose Plan button'.tr(),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            !getIt.get<DataLayer>().currentBusinessInfo[0]
                                    ['free_trial'] //did not get the free tiral
                                ? BlocBuilder<SubscriptionBloc,
                                    SubscriptionState>(
                                    builder: (context, state) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: CustomElevatedButton(
                                          onPressed: !bloc.selectedPlan[0]!
                                              ? null
                                              : () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return CustemAlertDialog(
                                                            title:
                                                                'Activated Your Free Trial?',
                                                            msg:
                                                                'By confirming, your free ${bloc.planType} subscription will begin on ${currentDate.day}/${currentDate.month}/${currentDate.year} and last until ${datePlus30Days.day}/${datePlus30Days.month}/${datePlus30Days.year}.',
                                                            onPressed: () {
                                                              bloc.add(confirmSubscription(
                                                                  isFreeTrial:
                                                                      true,
                                                                  start:
                                                                      currentDate,
                                                                  end:
                                                                      datePlus30Days));
                                                            },
                                                            buttonLable:
                                                                'Confirm');
                                                      });
                                                },
                                          backgroundColor: AppColors().green,
                                          child: Text('free Trial button'.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium),
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
