import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartIndicators extends StatelessWidget {
  final List getTopBranches;
  const ChartIndicators({super.key, required this.getTopBranches});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getTopBranches.length > 0
            ? ChartIndicator(
                address: getTopBranches[0]['address'],
                backgroundColor: Theme.of(context).primaryColor,
              )
            : SizedBox(),
        getTopBranches.length > 1
            ? ChartIndicator(
                address: getTopBranches[1]['address'],
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.8),
              )
            : SizedBox(),
        getTopBranches.length > 2
            ? ChartIndicator(
                address: getTopBranches[2]['address'],
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.6),
              )
            : SizedBox(),
        getTopBranches.length > 3
            ? ChartIndicator(
                address: getTopBranches[3]['address'],
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.4),
              )
            : SizedBox(),
        getTopBranches.length > 4
            ? ChartIndicator(
                address: getTopBranches[4]['address'],
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
              )
            : SizedBox()
      ],
    );
  }
}

class ChartIndicator extends StatelessWidget {
  final Color? backgroundColor;
  final String address;
  const ChartIndicator(
      {super.key, this.backgroundColor, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        children: [
          CircleAvatar(
            radius: 8,
            backgroundColor: backgroundColor,
          ),
          Expanded(
            child: Text(
              address,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class PiesChart extends StatelessWidget {
  final List<Map> topBranches;
  final double totalClicks;
  const PiesChart(
      {super.key, required this.topBranches, required this.totalClicks});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [];

    for (int i = 0; i < topBranches.length; i++) {
      double branchClicks = topBranches[i]['totalClicks'].toDouble();
      double percentage =
          totalClicks > 0 ? (branchClicks / totalClicks) * 100 : 0;

      sections.add(PieChartSectionData(
        title: '${percentage.toInt()}%',
        value: branchClicks, // actual clicks as the value
        color: Theme.of(context).primaryColor.withOpacity(1 - (i * 0.2)),
      ));
    }
    return AspectRatio(
      aspectRatio: 3,
      child: PieChart(PieChartData(
        sectionsSpace: 0,
        sections: sections,
      )),
    );
  }
}
