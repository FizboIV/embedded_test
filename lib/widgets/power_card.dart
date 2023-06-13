import 'package:flutter/material.dart';
import 'dart:io';

class PowerCard extends StatelessWidget {
  const PowerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Process.run('sudo', ['reboot']).then((ProcessResult result) {
          if (result.exitCode == 0) {
            print('System reboot initiated.');
          } else {
            print('Failed to reboot system.');
          }
        });
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          height: 107,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reboot',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.power_settings_new_rounded, size: 50, color: Theme.of(context).colorScheme.primary,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
