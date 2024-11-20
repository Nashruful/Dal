import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 14,
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
      fontSize: 12,
    );
    int maxValue = getmaximvalue().toInt();
    String text;
    if (value.toInt() == 0) {
      text = '0';
    } else if (value.toInt() == maxValue / 2) {
      text = (maxValue ~/ 2).toString();
    } else if (value.toInt() == maxValue) {
      text = maxValue.toString();
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  //get max views
  double getmaximvalue() {
    double maxY = 0;
    viewsByMonth.forEach((key, value) {
      if (value > maxY) {
        maxY = value.toDouble();
      }
    });
    return maxY;
  }

  LineChartData mainData() {
    return LineChartData(
      //grid lines
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
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
      maxY: getmaximvalue() + (getmaximvalue() * 0.2),
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
          //  isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,

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
}
