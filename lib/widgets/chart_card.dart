import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String title;

  const ChartCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '₪ 45,000',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: SimpleBarChart(
                data: [
                  BarData('يناير', 8000),
                  BarData('فبراير', 12000),
                  BarData('مارس', 7000),
                  BarData('أبريل', 10000),
                  BarData('مايو', 15000),
                  BarData('يونيو', 18000),
                ],
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarData {
  final String label;
  final double value;

  BarData(this.label, this.value);
}

class SimpleBarChart extends StatelessWidget {
  final List<BarData> data;
  final Color color;
  final double maxValue;

  SimpleBarChart({
    Key? key,
    required this.data,
    required this.color,
  }) : maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double barWidth = constraints.maxWidth / data.length - 16;
        
        return Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: data.map((item) {
                  final double barHeight = (item.value / maxValue) * constraints.maxHeight * 0.8;
                  
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '₪ ${item.value.toInt()}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: barWidth,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data.map((item) {
                return SizedBox(
                  width: barWidth,
                  child: Text(
                    item.label,
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}