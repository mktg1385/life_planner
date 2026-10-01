import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinanceChartData {
  final String title;
  final double value;

  const FinanceChartData({
    required this.title,
    required this.value,
  });
}

class FinanceChartCard extends StatelessWidget {
  final List<FinanceChartData> chartData;

  const FinanceChartCard({
    super.key,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: theme.brightness == Brightness.light
            ? const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: SfCircularChart(
        backgroundColor: Colors.transparent,

        legend: Legend(
          isVisible: true,
          textStyle: TextStyle(
            color: theme.colorScheme.onSurface,
          ),
        ),

        series: [
          DoughnutSeries<FinanceChartData, String>(
            dataSource: chartData,

            xValueMapper: (data, _) => data.title,

            yValueMapper: (data, _) => data.value,

            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),

            pointColorMapper: (data, _) {
              switch (data.title) {
                case 'درآمد':
                  return Colors.green;

                case 'هزینه':
                  return Colors.red;

                case 'پس‌انداز':
                  return Colors.blue;

                default:
                  return theme.colorScheme.primary;
              }
            },
          ),
        ],
      ),
    );
  }
}