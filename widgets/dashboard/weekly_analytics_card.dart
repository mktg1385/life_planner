import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyPoint {
  final String day;
  final double score;
  final bool hasData;

  WeeklyPoint({required this.day, required this.score, required this.hasData});
}

class WeeklyAnalyticsCard extends StatelessWidget {
  final List<WeeklyPoint> data;

  const WeeklyAnalyticsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final validData = data.where((e) => e.hasData).toList();

    final average = validData.isEmpty
        ? 0
        : validData.map((e) => e.score).reduce((a, b) => a + b) /
              validData.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: isDark
            ? []
            : const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics_outlined, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'تحلیل هفتگی',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'میانگین عملکرد هفته: ${average.toStringAsFixed(0)}%',
            style: TextStyle(color: theme.hintColor),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 220,
            child: SfCartesianChart(
              backgroundColor: Colors.transparent,

              plotAreaBorderWidth: 0,

              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: theme.cardColor,
                textStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),

              primaryXAxis: CategoryAxis(
                axisLine: AxisLine(color: theme.dividerColor),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: TextStyle(color: theme.textTheme.bodySmall?.color),
              ),

              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 100,
                interval: 20,

                axisLine: AxisLine(color: theme.dividerColor),

                majorGridLines: MajorGridLines(
                  color: theme.dividerColor.withOpacity(.25),
                ),

                labelStyle: TextStyle(color: theme.textTheme.bodySmall?.color),
              ),

              series: [
                ColumnSeries<WeeklyPoint, String>(
                  dataSource: data,

                  xValueMapper: (item, _) => item.day,

                  yValueMapper: (item, _) => item.score,

                  borderRadius: BorderRadius.circular(12),

                  pointColorMapper: (item, _) {
                    if (!item.hasData) {
                      return isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300;
                    }

                    if (item.score >= 80) {
                      return Colors.green;
                    }

                    if (item.score >= 50) {
                      return Colors.orange;
                    }

                    return Colors.red;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
