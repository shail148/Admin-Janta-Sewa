import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ApplicationOverviewChart extends StatelessWidget {
  const ApplicationOverviewChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: double.infinity,
        //padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Application Overview",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: AppColors.btnBgColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Chart
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    //horizontalInterval: 2000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: Colors.grey, strokeWidth: 1);
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        reservedSize: 50,
                        getTitlesWidget: (value, _) {
                          if (value == 0) return const Text('0');
                          if (value == 2000) return const Text('2K');
                          if (value == 4000) return const Text('4K');
                          if (value == 6000) return const Text('6K');
                          if (value == 8000) return const Text('8K');
                          if (value == 10000) return const Text('10K');
                          return const SizedBox();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval: 1,
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text("Mon");
                            case 1:
                              return const Text("Tue");
                            case 2:
                              return const Text("Wed");
                            case 3:
                              return const Text("Thu");
                            case 4:
                              return const Text("Fri");
                            case 5:
                              return const Text("Sat");
                            case 6:
                              return const Text("Sun");
                            default:
                              return const SizedBox();
                          }
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 10000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1000),
                        FlSpot(1, 3500),
                        FlSpot(2, 500),
                        FlSpot(3, 4000),
                        FlSpot(4, 6000),
                        FlSpot(5, 4000),
                        FlSpot(6, 7000),
                      ],
                      isCurved: true,
                      color: AppColors.btnBgColor,
                      // gradient: const LinearGradient(
                      //   colors: [Color(0xff7DA0F7), Color(0xff7DA0F7)],
                      // ),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,

                        gradient: LinearGradient(
                          colors: [
                            // ignore: deprecated_member_use
                            Color(0xff7DA0F7),
                            // ignore: deprecated_member_use
                            Color(0xffFEFEFE),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            "${spot.y.toInt()}",
                            const TextStyle(
                              // backgroundColor: Colors.white,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
