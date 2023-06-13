import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatefulWidget {
  const CustomLineChart(
      {super.key,
      required this.cpuData,
      required this.cpuPoints,
      required this.aspectRatio,
      this.axisName = ''});

  final double cpuData;
  final List<FlSpot> cpuPoints;
  final double aspectRatio;
  final String axisName;

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  @override
  Widget build(BuildContext context) {
    return widget.cpuPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: 100,
                      minX: widget.cpuPoints.first.x,
                      maxX: widget.cpuPoints.last.x,
                      lineTouchData: LineTouchData(enabled: false),
                      //clip Data to hide the line outside the chart
                      clipData: FlClipData.all(),
                      //show the grid
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      //border Style of the chart
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        //cpuDummyLine(cpuDummyPoints),
                        cpuLine(widget.cpuPoints),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(),
                        bottomTitles: AxisTitles(),
                        topTitles: AxisTitles(),
                        leftTitles: AxisTitles(
                          drawBehindEverything: false,
                          axisNameSize: 25,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              const style = TextStyle(
                                fontSize: 14,
                              );
                              return SideTitleWidget(
                                space: 0.1,
                                axisSide: meta.axisSide,
                                child: Text('${value.toStringAsFixed(0)}%',
                                    style: style),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CPU: ${widget.cpuPoints.last.y}%',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )
        : Container();
  }

  LineChartBarData cpuLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      color: Theme.of(context).colorScheme.primary,
      barWidth: 2,
      isCurved: true,
    );
  }

  @override
  void dispose() {
    //timer.cancel();
    super.dispose();
  }
}
