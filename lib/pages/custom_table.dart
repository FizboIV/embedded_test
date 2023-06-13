import 'package:flutter/material.dart';
import '../../widgets/side_navigation.dart';
import '../../widgets/demo_data_table.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          SideNavigation(),
          Expanded(child: Card(child: DemoDataTable())),
        ],
      ),
    );
  }
}
