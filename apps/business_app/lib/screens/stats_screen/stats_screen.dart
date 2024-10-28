import 'package:components/component/custom_cards/stats_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(), //custom
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatCards(
                    lable: 'Total Ads'.tr(),
                    numbers: 12,
                  ),
                  StatCards(
                    lable: 'Total Views'.tr(),
                    numbers: 1234,
                  ),
                  StatCards(
                    lable: 'Total Clicks'.tr(),
                    numbers: 234,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: AspectRatio(
                aspectRatio: 2,
                child: PieChart(PieChartData(sections: [
                  PieChartSectionData(
                      value: 10, color: Theme.of(context).primaryColor),
                  PieChartSectionData(
                      value: 10, color: Theme.of(context).hintColor),
                  PieChartSectionData(
                    value: 10,
                  ),
                ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: AspectRatio(
                aspectRatio: 2,
                child: BarChart(
                  BarChartData(barGroups: [
                    BarChartGroupData(
                        x: 0, barRods: [BarChartRodData(toY: 12)]),
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 1)]),
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 2)]),
                    BarChartGroupData(
                        x: 0, barRods: [BarChartRodData(toY: 20)]),
                  ]),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
