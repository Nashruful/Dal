import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/stats_screen/cubit/statistics_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_cards/stats_card.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
                  title: 'Statistics', automaticallyImplyLeading: false),
              body: RefreshIndicator(
                onRefresh: () => cubit.refreshScreen(),
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Top 5 Branches By Ads',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: PiesChart(),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Monthly Ad Performance',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 16),
                        //   child: AspectRatio(
                        //     aspectRatio: 2,
                        //     child: BarChart(
                        //       BarChartData(barGroups: [
                        //         BarChartGroupData(
                        //             x: 0, barRods: [BarChartRodData(toY: 12)]),
                        //         BarChartGroupData(
                        //             x: 0, barRods: [BarChartRodData(toY: 1)]),
                        //         BarChartGroupData(
                        //             x: 0, barRods: [BarChartRodData(toY: 2)]),
                        //         BarChartGroupData(
                        //             x: 0, barRods: [BarChartRodData(toY: 20)]),
                        //       ]),
                        //     ),
                        //   ),
                        // ),
                        LineChartSample(
                          viewsByMonth: cubit.viewsByMonth,
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

class PiesChart extends StatelessWidget {
  const PiesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(sections: [
      PieChartSectionData(
          title: 'aa', value: 10, color: Theme.of(context).primaryColor),
      PieChartSectionData(
          title: 'aa',
          value: 10,
          color: Theme.of(context).primaryColor.withOpacity(0.8)),
      PieChartSectionData(
          title: 'aa',
          value: 10,
          color: Theme.of(context).primaryColor.withOpacity(0.6)),
      PieChartSectionData(
          title: 'aa',
          value: 10,
          color: Theme.of(context).primaryColor.withOpacity(0.4)),
      PieChartSectionData(
          title: 'aa',
          value: 10,
          color: Theme.of(context).primaryColor.withOpacity(0.2)),
    ]));
  }
}

class LineChartSample extends StatelessWidget {
  final Map viewsByMonth;
  LineChartSample({super.key, required this.viewsByMonth});

  final List<Color> gradientColors = [
    AppColors().green,
    AppColors().green,
  ];

  final bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              //    showAvg ? avgData(viewsByMonth) :
              mainData(),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              // setState(() {
              //   showAvg = !showAvg;
              // });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 4:
        text = const Text('MAY', style: style);
        break;
      case 6:
        text = const Text('JUL', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 10:
        text = const Text('NOV', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    double maxY = 0;
    return LineChartData(
      //grid lines
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        //   horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors().green,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors().green,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),

      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 1000,
      lineBarsData: [
        LineChartBarData(
          //month, impressions number
          spots: [
            FlSpot(0, viewsByMonth[1]),
            FlSpot(1, viewsByMonth[2]),
            FlSpot(2, viewsByMonth[3]),
            FlSpot(3, viewsByMonth[4]),
            FlSpot(4, viewsByMonth[5]),
            FlSpot(5, viewsByMonth[6]),
            FlSpot(6, viewsByMonth[7]),
            FlSpot(7, viewsByMonth[8]),
            FlSpot(8, viewsByMonth[9]),
            FlSpot(9, viewsByMonth[10]),
            FlSpot(10, viewsByMonth[11]),
            FlSpot(11, viewsByMonth[12]),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          // dotData: const FlDotData(
          //   show: false,
          // ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  ///-----------------

  // LineChartData avgData(Map viewsByMonth) {
  //   return LineChartData(
  //     lineTouchData: const LineTouchData(enabled: false),
  //     gridData: FlGridData(
  //       show: true,
  //       drawHorizontalLine: true,
  //       verticalInterval: 1,
  //       horizontalInterval: 1,
  //       getDrawingVerticalLine: (value) {
  //         return const FlLine(
  //           color: Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //       getDrawingHorizontalLine: (value) {
  //         return const FlLine(
  //           color: Color.fromARGB(255, 24, 135, 225),
  //           strokeWidth: 1,
  //         );
  //       },
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 30,
  //           getTitlesWidget: bottomTitleWidgets,
  //           interval: 1,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: leftTitleWidgets,
  //           reservedSize: 42,
  //           interval: 1,
  //         ),
  //       ),
  //       topTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       rightTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: true,
  //       border: Border.all(color: const Color(0xff37434d)),
  //     ),
  //     minX: 0,
  //     maxX: 11,
  //     minY: 0,
  //     maxY: 6,
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: [

  //         ],
  //         isCurved: true,
  //         gradient: LinearGradient(
  //           colors: [
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //           ],
  //         ),
  //         barWidth: 5,
  //         isStrokeCapRound: true,
  //         dotData: const FlDotData(
  //           show: false,
  //         ),
  //         belowBarData: BarAreaData(
  //           show: true,
  //           gradient: LinearGradient(
  //             colors: [
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
