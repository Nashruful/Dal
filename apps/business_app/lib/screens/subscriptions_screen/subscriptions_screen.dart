import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/subscriptions_screen/bloc/subscriptions_screen_bloc_bloc.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_cards/subscriptions_card.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moyasar/moyasar.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => SubscriptionBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<SubscriptionBloc>();
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(
                title: 'Subscription Plan', automaticallyImplyLeading: true),
            body: Center(
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
                                        MediaQuery.of(context).size.height / 4,
                                    child: SvgPicture.asset(
                                        'assets/svg/Objective.svg'))),
                          ),
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
                                      duration: 'subscription three month'.tr(),
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
                          SizedBox(
                            height: 15,
                          ),
                          BlocBuilder<SubscriptionBloc, SubscriptionState>(
                            builder: (context, state) {
                              return Text(bloc.planDesc,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          !getIt.get<DataLayer>().currentBusinessInfo[0]
                                  ['free_trial'] //did not get the free tiral
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: CustomElevatedButton(
                                    onPressed: () {
                                      //
                                    },
                                    backgroundColor: AppColors().green,
                                    child: Text('free Trial button'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                )
                              : SizedBox(),
                          CustomElevatedButton(
                            onPressed: () {
                              //
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height: 600,
                                      child: Column(
                                        children: [
                                          Text(
                                              'plan from ${DateTime.now()} to ${DateTime.now()..add(Duration(days: 30))}')
                                        ],
                                      ),
                                    );
                                  });
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              'choose Plan button'.tr(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
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
