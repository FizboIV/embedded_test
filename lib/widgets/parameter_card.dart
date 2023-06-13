import 'package:flutter/material.dart';

class ParameterCard extends StatelessWidget {
  const ParameterCard(
      {Key? key, required this.title, required this.unit, required this.value})
      : super(key: key);

  final String title;
  final String unit;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        height: 107,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 34),
                ),
                Text(
                  ' $unit',
                  style: const TextStyle(fontSize: 26),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
