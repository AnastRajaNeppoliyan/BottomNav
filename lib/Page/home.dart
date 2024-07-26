import 'package:flutter/material.dart';

import 'ChartOkBackup.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Config data
    const config = {
      'data': [
        {'status': 2, 'd': '2022-01-01 00:00'},
        {'status': 1, 'd': '2022-01-01 08:00'},
        {'status': 3, 'd': '2022-01-01 10:00'},
        {'status': 2, 'd': '2022-01-01 12:00'},
        {'status': 2, 'd': '2022-01-01 18:00'},
        {'status': 4, 'd': '2022-01-01 20:00'},
        {'status': 2, 'd': '2022-01-01 21:00'},
        // End of day to ensure the chart is finished
      ],
      // 'options': {
      //   'startStatus': 2,
      //   'startOffDutyHours': 2.0,
      //   'startDrivingHours': 3.0,
      //   'startDutyHours': 1.0,
      //   'startDate': '2022-01-01 00:00'
      // },
    };

    return Scaffold(
      appBar: AppBar(title: Text('Timeline Chart')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width, 200), // Reduced height
              painter: ELogPainter(config: config),
            ),
          ),
        ),
      ),
    );
  }
}
