import 'package:flutter/material.dart';
import 'dart:math' as math;

class DemoDataTable extends StatefulWidget {
  const DemoDataTable({Key? key}) : super(key: key);

  @override
  State<DemoDataTable> createState() => _DemoDataTableState();
}

class _DemoDataTableState extends State<DemoDataTable> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Time')),
            DataColumn(label: Text('CPU [%]')),
            DataColumn(label: Text('RAM [MB]')),
            DataColumn(label: Text('Memory [MB]')),
          ],
          rows: _generateDataRows(),
        ),
      ],
    );
  }

  List<DataRow> _generateDataRows() {
    List<DataRow> rows = [];
    List<_Data> data = _generateData();

    for (int i = 0; i < data.length; i++) {
      _Data rowData = data[i];
      DataRow dataRow = DataRow(
        cells: <DataCell>[
          DataCell(Text(rowData.time)),
          DataCell(Text(rowData.cpu.toStringAsFixed(0))),
          DataCell(Text(rowData.ram.toStringAsFixed(0))),
          DataCell(Text(rowData.memory.toStringAsFixed(0))),
        ],
      );
      rows.add(dataRow);
    }

    return rows;
  }

  List<_Data> _generateData() {
    List<_Data> data = [];

    for (int i = 0; i < 100; i++) {
      data.add(_Data(
        DateTime.now().add(Duration(minutes: i)).toString().split('.')[0],
        math.Random().nextInt(12) + 13,
        math.Random().nextInt(41) + 120,
        2765996,
      ));
    }

    return data;
  }
}

class _Data {
  _Data(this.time, this.cpu, this.ram, this.memory);

  final String time;
  final double cpu;
  final double ram;
  final int memory;
}
