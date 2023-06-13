import 'package:embedded_test/widgets/power_card.dart';
import 'package:embedded_test/widgets/side_navigation.dart';
import 'package:embedded_test/widgets/parameter_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/line_chart.dart';
import '../../util/util.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideNavigation(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Consumer<LiveDataModel>(
                builder: (context, state, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Expanded(child: PowerCard()),
                          Expanded(
                            child: ParameterCard(
                              title: 'RAM Used/Total',
                              unit: 'Mb',
                              value:
                                  '${state.ramUsed.toStringAsFixed(0)}/${state.ramTotal.toStringAsFixed(0)}',
                            ),
                          ),
                          Expanded(
                            child: ParameterCard(
                              title: 'Disk Space Used/Total',
                              unit: 'Gb',
                              value:
                                  '${(state.storageUsed / 1000000).toStringAsFixed(1)}/${(state.storageTotal / 1000000).toStringAsFixed(1)}',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Temperature',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '${state.temp.toStringAsFixed(1)}°C',
                                          style: const TextStyle(fontSize: 34),
                                        )
                                      ],
                                    ),
                                    LinearProgressIndicator(
                                        value: state.temp / 100, minHeight: 4),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 16, 16, 16),
                                child: Consumer<LiveDataModel>(
                                  builder: (context, state, child) {
                                    return CustomLineChart(
                                      aspectRatio: 3.45,
                                      cpuData: state.cpu,
                                      cpuPoints: state.cpuPoints,
                                      axisName: 'CPU Usage',
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
