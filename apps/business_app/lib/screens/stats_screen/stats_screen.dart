import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/stats_screen/charts/line_chart.dart';
import 'package:business_app/screens/stats_screen/charts/pie_chart.dart';
import 'package:business_app/screens/stats_screen/cubit/statistics_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_cards/stats_card.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  int getTotalAds() {
    final totalAds = getIt.get<DataLayer>().allbusinessAds.length;
    return totalAds;
  }

  int getTotalViews(List adList) {
    int totalViews = 0;
    for (final ad in adList) {
      if (ad['views'] != null) {
        totalViews += ad['views'] as int;
      }
    }
    return totalViews;
  }

  int getTotalClicks(List adList) {
    int totalClicks = 0;
    for (final ad in adList) {
      if (ad['clicks'] != null) {
        totalClicks += ad['clicks'] as int;
      }
    }
    return totalClicks;
  }

  List<Map> getTopBranches() {
    final branches = getIt.get<DataLayer>().businessBranches;
    Map<String, int> branchTotalClicks = {};
    List<Map<String, dynamic>> result = [];
    for (final branch in branches) {
      int totalClicks = 0;

      for (final ad in branch['ad']) {
        final int clicks = ad['clicks'];

        totalClicks += clicks;
      }

      branchTotalClicks[branch['id']] = totalClicks;
    }

    // Sort the branches
    final sortedBranches = branchTotalClicks.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Get the top 5 branches as a list
    for (int i = 0;
        i < (sortedBranches.length < 5 ? sortedBranches.length : 5);
        i++) {
      final branchId = sortedBranches[i].key;
      final branch = branches.firstWhere((b) => b['id'] == branchId);
      result.add({
        'id': branchId,
        'address': branch['address'],
        'totalClicks': sortedBranches[i].value,
      });
    }

    return result;
  }

  Map<int, double> getViewsByMonth(List allads) {
    final Map<int, double> viewsByMonth = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
    };
    for (final ad in allads) {
      int month = DateTime.parse(ad['startdate']).month;
      int views = ad['views'] as int;
      viewsByMonth[month] = (viewsByMonth[month] ?? 0) + views;
    }
    return viewsByMonth;
  }

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
              appBar: const CustomAppBar(
                  title: 'Statistics', automaticallyImplyLeading: true),
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
                                      numbers: getTotalAds()),
                                  StatCards(
                                    lable: "Total Views".tr(),
                                    numbers: getTotalViews(cubit.allads),
                                  ),
                                  StatCards(
                                    lable: "Total Clicks".tr(),
                                    numbers: getTotalClicks(cubit.allads),
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
                            'Top 5 Branches By Ad Clicks',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        ChartIndicators(
                          getTopBranches: getTopBranches(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: PiesChart(
                            topBranches: getTopBranches(),
                            totalClicks:
                                getTotalClicks(cubit.allads).toDouble(),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Monthly Ad Performance',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        LineChartSample(
                          viewsByMonth: getViewsByMonth(cubit.allads),
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
