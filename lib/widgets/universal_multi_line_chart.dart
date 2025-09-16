// ignore_for_file: deprecated_member_use

import 'package:admin_jantasewa/controllers/railTicket/rail_ticket_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Selectable ranges (optional)

/// One series = one colored line
class ChartSeries {
  final String name; // e.g. Approved
  final List<FlSpot> spots; // e.g. [FlSpot(0,2), FlSpot(1,5)]
  final Color color;
  final bool filled; // area fill below the line
  const ChartSeries({
    required this.name,
    required this.spots,
    required this.color,
    this.filled = true,
  });
}

/// Reusable multi-series line chart with optional title, legend and range toggle.
class UniversalMultiLineChart extends StatelessWidget {
  final String? title;
  final List<String> xLabels; // Week: 7 | Month: 28-31 | Year: 12
  final List<ChartSeries> series; // Multiple lines
  final double height;

  /// Show/hide parts
  final bool showLegend;
  final bool showGrid;
  final bool showYAxis;
  final bool showRangeToggle;

  /// Range toggle state (optional)
  final ChartRange? range;
  final ValueChanged<ChartRange>? onRangeChanged;

  /// Styling
  final Color background;
  final Color gridColor;
  final Color borderColor;
  final double lineWidth;
  final double dotRadius;

  const UniversalMultiLineChart({
    super.key,
    required this.xLabels,
    required this.series,
    this.title,
    this.height = 250,
    this.showLegend = true,
    this.showGrid = true,
    this.showYAxis = true,
    this.showRangeToggle = false,
    this.range,
    this.onRangeChanged,
    this.background = const Color(0xFFF7F8FC),
    this.gridColor = const Color(0xFFE6E8F5),
    this.borderColor = const Color(0xFFE6E8F5),
    this.lineWidth = 1.5,
    this.dotRadius = 2,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = _maxY(series);
    final noData = series.isEmpty || series.every((s) => s.spots.isEmpty);

    return Container(
      height: height,
      //margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.only(right: 12, left: 6, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || showRangeToggle) _titleRow(context),
          Expanded(
            child: noData
                ? const Center(child: Text('No data'))
                : LineChart(
                    LineChartData(
                      //clipData: FlClipData.none(),
                      minX: 0,
                      maxX: (xLabels.length - 1).toDouble(),
                      minY: 0,
                      maxY: (maxY + 10).toDouble(),

                      gridData: FlGridData(
                        show: showGrid,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (v) =>
                            FlLine(color: gridColor, strokeWidth: 1),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          top: BorderSide(color: Colors.transparent),
                          right: BorderSide(color: Colors.transparent),
                          left: BorderSide(color: borderColor),
                          bottom: BorderSide(color: borderColor),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: showYAxis,
                            reservedSize: 15,
                            interval: _yInterval(maxY),
                            getTitlesWidget: (v, _) => Text(
                              v.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF5C6275),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: _xInterval(xLabels.length),
                            getTitlesWidget: (value, _) {
                              final i = value.toInt();
                              if (i < 0 || i >= xLabels.length) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  xLabels[i],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF5C6275),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => Color(0xFF403572),
                          // tooltipBgColor: Colors.black87,
                          // tooltipRoundedRadius: 8,
                          tooltipPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          getTooltipItems: (items) => items.map((it) {
                            final idx = it.x.toInt();
                            final day = (idx >= 0 && idx < xLabels.length)
                                ? xLabels[idx]
                                : '';
                            // find series name by color match (simple + fast)
                            final s = series.firstWhere(
                              (e) =>
                                  e.color.value ==
                                  (it.bar.color?.value ?? e.color.value),
                              orElse: () => ChartSeries(
                                name: '',
                                spots: const [],
                                color: Colors.white,
                              ),
                            );
                            return LineTooltipItem(
                              textAlign: TextAlign.left,

                              '${s.name.isNotEmpty ? '${s.name}:' : ''}$day: ${it.y.toInt()}',
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                              textDirection: TextDirection.ltr,
                            );
                          }).toList(),
                        ),
                      ),
                      lineBarsData: series.map((s) {
                        return LineChartBarData(
                          spots: s.spots,
                          isCurved: true,
                          barWidth: lineWidth,
                          color: s.color,
                          dotData: FlDotData(
                            show: true,
                            // getDotPainter: (p, __, ___, ____) =>
                            //     FlDotCirclePainter(
                            //       radius: dotRadius,
                            //       color: Colors.white,
                            //       strokeWidth: 1,
                            //       strokeColor: s.color,
                            //     ),
                          ),
                          belowBarData: BarAreaData(
                            show: s.filled,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                s.color.withOpacity(.22),

                                s.color.withOpacity(.04),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
          // if (showLegend) _legend(),
        ],
      ),
    );
  }

  Widget _titleRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 6, top: 0),
      child: Row(
        children: [
          if (title != null) Text(title!, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          if (showRangeToggle)
            Row(
              children: [
                _rangeChip(
                  'W',
                  range == ChartRange.week,
                  () => onRangeChanged?.call(ChartRange.week),
                ),
                const SizedBox(width: 6),
                _rangeChip(
                  'M',
                  range == ChartRange.month,
                  () => onRangeChanged?.call(ChartRange.month),
                ),
                const SizedBox(width: 6),
                _rangeChip(
                  'Y',
                  range == ChartRange.year,
                  () => onRangeChanged?.call(ChartRange.year),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // Widget _legend() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 4, top: 6),
  //     child: Wrap(
  //       spacing: 12,
  //       runSpacing: 6,
  //       children: series.map((s) {
  //         return Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               width: 10,
  //               height: 10,
  //               decoration: BoxDecoration(
  //                 color: s.color,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //             const SizedBox(width: 6),
  //             // Text(s.name, style: const TextStyle(fontSize: 11)),
  //           ],
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  static Widget _rangeChip(String t, bool active, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF403572) : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFF403572)),
          ),
          child: Text(
            t,
            style: TextStyle(
              fontSize: 11,
              color: active ? Colors.white : const Color(0xFF403572),
            ),
          ),
        ),
      );

  // ---- helpers ----
  static double _xInterval(int len) {
    if (len <= 7) return 1; // week
    if (len <= 31) return 2; // month
    return 2; // 12 ticks for year
  }

  static double _yInterval(double maxY) {
    if (maxY <= 5) return 2;
    if (maxY <= 20) return 5;
    if (maxY <= 100) return 10;
    return (maxY / 5).ceilToDouble();
  }

  static double _maxY(List<ChartSeries> series) {
    double m = 0;
    for (final s in series) {
      for (final sp in s.spots) {
        if (sp.y > m) m = sp.y;
      }
    }
    return m == 0 ? 1 : m;
  }
}
