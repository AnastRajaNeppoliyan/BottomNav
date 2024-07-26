import 'package:flutter/material.dart';

class ELogPainter extends CustomPainter {
  final Map<String, dynamic> config;

  ELogPainter({required this.config});

  @override
  void paint(Canvas canvas, Size size) {
    // Extract data and options from config
    final List<Map<String, dynamic>> data = config['data'];
    final Map<String, dynamic> options = config['options'] ?? {};

    // Set up paint objects
    Paint bgPaint = Paint()..color = Colors.white;
    Paint linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    Paint headerPaint = Paint()..color = Colors.red;
    Paint statusPaint = Paint()..color = Colors.red[300]!;
    Paint dataPaint = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 4;
    Paint totalBgPaint = Paint()..color = Colors.lightBlue[100]!;

    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Draw header block
    double headerHeight = size.height * 0.1;
    double statusWidth = size.width * 0.1;
    double totalWidth = size.width * 0.1;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, headerHeight), headerPaint);

    // Draw status column
    canvas.drawRect(
        Rect.fromLTWH(0, headerHeight, statusWidth, size.height - headerHeight),
        statusPaint);

    // Draw header text
    List<String> hours = [
      'M',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      'N',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11'
    ];
    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < 24; i++) {
      textPainter.text = TextSpan(
        text: hours[i],
        style: TextStyle(
          color: Colors.white,
          fontSize: 12, // Reduced font size
        ),
      );
      textPainter.layout(minWidth: 0, maxWidth: size.width / 24);
      textPainter.paint(
          canvas,
          Offset(
              statusWidth +
                  (size.width - statusWidth - totalWidth) / 24 * i +
                  ((size.width - statusWidth - totalWidth) / 24 -
                          textPainter.width) /
                      2,
              (headerHeight - textPainter.height) / 2));
    }

    // Draw status text and totals
    List<String> statuses = ['OFF', 'SB', 'D', 'ON'];
    // Here, we can calculate totals dynamically if needed
    List<String> totals = ['4:00', '12:00', '7:45', '0:15'];
    for (int i = 0; i < 4; i++) {
      textPainter.text = TextSpan(
        text: statuses[i],
        style: TextStyle(
          color: Colors.white,
          fontSize: 12, // Reduced font size
        ),
      );
      textPainter.layout(minWidth: 0, maxWidth: statusWidth);
      textPainter.paint(
          canvas,
          Offset(
              (statusWidth - textPainter.width) / 2,
              headerHeight +
                  (size.height - headerHeight) / 4 * i +
                  ((size.height - headerHeight) / 4 - textPainter.height) / 2));

      // Draw total background
      double totalBgX = size.width - totalWidth;
      double totalBgY = headerHeight + (size.height - headerHeight) / 4 * i;
      double totalBgHeight = (size.height - headerHeight) / 4;
      canvas.drawRect(
          Rect.fromLTWH(totalBgX, totalBgY, totalWidth, totalBgHeight),
          totalBgPaint);

      // Draw total text
      textPainter.text = TextSpan(
        text: totals[i],
        style: TextStyle(
          color: Colors.lightBlue,
          fontSize: 12, // Reduced font size
        ),
      );
      textPainter.layout(minWidth: 0, maxWidth: totalWidth);
      textPainter.paint(
          canvas,
          Offset(totalBgX + (totalWidth - textPainter.width) / 2,
              totalBgY + (totalBgHeight - textPainter.height) / 2));
    }

    // Draw vertical and horizontal lines
    for (int i = 0; i <= 24; i++) {
      double x = statusWidth + (size.width - statusWidth - totalWidth) / 24 * i;
      canvas.drawLine(
          Offset(x, headerHeight), Offset(x, size.height), linePaint);
    }
    for (int i = 0; i <= 4; i++) {
      double y = headerHeight + (size.height - headerHeight) / 4 * i;
      canvas.drawLine(Offset(statusWidth, y),
          Offset(size.width - totalWidth, y), linePaint);
    }

    // Parse date and time data into hour values
    List<Map<String, dynamic>> parsedData = data.map((entry) {
      DateTime dateTime = DateTime.parse(entry['d']);
      int hour = dateTime.hour;
      int minute = dateTime.minute;
      double timeInHours = hour + minute / 60.0;
      return {'status': entry['status'], 'time': timeInHours};
    }).toList();

    // Draw data lines and connecting lines
    for (int i = 0; i < parsedData.length; i++) {
      var entry = parsedData[i];
      double startX = statusWidth +
          (size.width - statusWidth - totalWidth) / 24 * entry['time'];
      double endX = startX; // Single point for now
      double y = headerHeight +
          (size.height - headerHeight) / 4 * (entry['status'] - 1) +
          (size.height - headerHeight) / 8;
      if (i > 0) {
        var prevEntry = parsedData[i - 1];
        double prevY = headerHeight +
            (size.height - headerHeight) / 4 * (prevEntry['status'] - 1) +
            (size.height - headerHeight) / 8;
        canvas.drawLine(Offset(startX, prevY), Offset(startX, y),
            dataPaint); // Vertical connecting line
      }
      if (i < parsedData.length - 1) {
        var nextEntry = parsedData[i + 1];
        double nextTime = nextEntry['time'];
        double nextX = statusWidth +
            (size.width - statusWidth - totalWidth) / 24 * nextTime;
        canvas.drawLine(Offset(startX, y), Offset(nextX, y),
            dataPaint); // Horizontal line to next point
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
