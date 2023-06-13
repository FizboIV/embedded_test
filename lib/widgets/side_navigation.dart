import 'package:embedded_test/pages/custom_table.dart';
import 'package:embedded_test/pages/dashboard.dart';
import 'package:embedded_test/pages/real_time_chart.dart';
import 'package:flutter/material.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 88,
      child: Column(
        children: [
          IconButton(
            onPressed: () {Navigator.pushReplacement(context, PageRouteBuilder (
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return const Dashboard();
              },
            ));},
            icon: const Icon(
              Icons.home_rounded,
              size: 40,
            ),
          ),
          const SizedBox(
            height: 36 ,
          ),
          IconButton(
            onPressed: () {Navigator.pushReplacement(context, PageRouteBuilder (
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return const RealTimeChart();
                },
            ));},
            icon: const Icon(
              Icons.show_chart_rounded,
              size: 40,
            ),),
          const SizedBox(
            height: 36,
          ),
          IconButton(
            onPressed: () {Navigator.pushReplacement(context, PageRouteBuilder (
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return const CustomTable();
              },
            ));},
            icon: const Icon(
              Icons.table_chart,
              size: 40,
            ),)
        ],
      ),
    );
  }
}
