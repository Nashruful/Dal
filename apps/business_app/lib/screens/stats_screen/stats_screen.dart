import 'package:business_app/screens/stats_screen/charts/line_chart.dart';
import 'package:business_app/screens/stats_screen/charts/pie_chart.dart';
import 'package:business_app/screens/stats_screen/cubit/statistics_cubit.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_cards/stats_card.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<StatisticsCubit, StatisticsState>(
          builder: (context, state) {
            final cubit = context.read<StatisticsCubit>();
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: CustomAppBar(
                  title: 'Statistics'.tr(), automaticallyImplyLeading: true),
              body: RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () => cubit.refreshScreen(),
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  StatCards(
                                      lable: 'Total Ads'.tr(),
                                      numbers: cubit.getTotalAds()),
                                  StatCards(
                                    lable: "Total Views".tr(),
                                    numbers: cubit.getTotalViews(cubit.allads),
                                  ),
                                  StatCards(
                                    lable: "Total Clicks".tr(),
                                    numbers: cubit.getTotalClicks(cubit.allads),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Top 5 Branches By Ad Clicks'.tr(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        ChartIndicators(
                          getTopBranches: cubit.getTopBranches(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: PiesChart(
                            topBranches: cubit.getTopBranches(),
                            totalClicks:
                                cubit.getTotalClicks(cubit.allads).toDouble(),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Monthly Ad Performance'.tr(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        LineChartSample(
                          viewsByMonth: cubit.getViewsByMonth(cubit.allads),
                        )
                      ],
                    ),
                  ),
                )),
              ),
            );
          },
        );
      }),
    );
  }
}
