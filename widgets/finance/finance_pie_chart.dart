import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FinancePieItem {
  final String category;
  final double value;

  const FinancePieItem({required this.category, required this.value});
}

class FinancePieChart extends StatelessWidget {
  final List<FinancePieItem> items;

  const FinancePieChart({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SfCircularChart(
        legend: const Legend(isVisible: true),
        series: [
          PieSeries<FinancePieItem, String>(
            dataSource: items,
            xValueMapper: (item, _) => item.category,
            yValueMapper: (item, _) => item.value,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
