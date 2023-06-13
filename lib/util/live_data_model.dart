import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;


class LiveDataModel extends ChangeNotifier {
  double xValue = 0;
  double step = 0.04;
  final limitCount = 175;
  late Timer timer;
  DateTime _timestamp = DateTime(0, 0, 0, 0, 0,0,0);

  double _cpu = 0.0;
  final cpuPoints = <FlSpot>[];
  double _storageTotal = 0.0;
  double _ramUsed = 0.0;
  double _ramTotal = 0.0;
  final ramPoints = <FlSpot>[];
  double _temp = 0.0;
  double _storageUsed = 0.0;
  double _storageAvailable = 0.0;

  double get cpu => _cpu;
  double get ramUsed => _ramUsed;
  double get ramTotal => _ramTotal;
  double get temp => _temp;
  DateTime get timestamp => _timestamp;
  double get storageTotal => _storageTotal;
  double get storageUsed => _storageUsed;
  double get storageAvailable => _storageAvailable;

  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/liveDataLog.csv');
  }


  liveDataListener(Duration duration) {
    timer = Timer.periodic(duration, (timer) {
    _updateData();
    updateDataLists();
    });
  }

  DateTime parseTimeString(String timeString) {
    List<String> timeParts = timeString.split(':');
    int year = int.parse(timeParts[0]);
    int month = int.parse(timeParts[1]);
    int day = int.parse(timeParts[2]);
    int hours = int.parse(timeParts[3]);
    int minutes = int.parse(timeParts[4]);
    int seconds = int.parse(timeParts[5]);
    int milliseconds = int.parse(timeParts[6]);
    return DateTime(year, month, day, hours, minutes, seconds, milliseconds);
  }

  //0..timestamp
  //1..cpu (in %)
  //2..storageTotal (in KB)
  //3..storageUsed (in KB)
  //4..storageAvailable (in KB)
  //5..ramUsed (in KB)
  //6..ramTotal (in KB)
  //7..temp (in °C)

  Future<void> _updateData() async {
    try {
      final file = await _localFile;
      String csvData = await file.readAsString();

      List<List<dynamic>> rows = const CsvToListConverter(
        eol: '\n',
        fieldDelimiter: ',',
      ).convert(csvData);

      _timestamp = parseTimeString(rows.last[0].toString());
      _cpu = double.parse(rows.last[1].toString());
      _storageTotal = double.parse(rows.last[2].toString());
      _storageUsed = double.parse(rows.last[3].toString());
      _storageAvailable = double.parse(rows.last[4].toString());
      _ramUsed = double.parse(rows.last[5].toString());
      _ramTotal = double.parse(rows.last[6].toString());
      _temp = double.parse(rows.last[7].toString());

      notifyListeners();
    } catch (e) {
      //print("Fehler beim Lesen der CSV-Datei: $e");
      _cpu = (math.Random().nextInt(12) + 13);
      _storageTotal = (31700000);
      _storageUsed = (2765996);
      _storageAvailable = (_storageTotal- _storageUsed);
      _ramUsed = (math.Random().nextInt(41) + 120);
      _ramTotal = (200);
      _temp = (math.Random().nextInt(16) + 60);
      notifyListeners();
    }
  }

  updateDataLists () {
    while (cpuPoints.length > limitCount) {
      cpuPoints.removeAt(0);
    }
    cpuPoints.add(FlSpot(xValue, _cpu));
    xValue += step;
    notifyListeners();
  }
}