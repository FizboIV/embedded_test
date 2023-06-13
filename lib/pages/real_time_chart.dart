import 'package:embedded_test/widgets/side_navigation.dart';
import 'package:embedded_test/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/line_chart.dart';

class RealTimeChart extends StatelessWidget {
  const RealTimeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideNavigation(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Consumer<LiveDataModel>(
                      builder: (context, state, child) {
                        return CustomLineChart(
                          aspectRatio: 1.8,
                          cpuData: state.cpu,
                          cpuPoints: state.cpuPoints,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
