// features/home/persentation/views/home_screen.dart
import 'dart:async';
import 'dart:math';
import 'package:alarm/core/functions/navigation.dart';
import 'package:alarm/core/widget/custom_button.dart';
import 'package:alarm/features/home/persentation/views/alarms_screen.dart';
import 'package:alarm/features/home/persentation/widget/bottomsheet.dart';
import 'package:alarm/features/home/persentation/widget/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime(Timer timer) {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: const Size(350, 350),
              painter: ClockPainter(_currentTime),
            ),
            Gap(mediaquery.height * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Gap(mediaquery.width * .05),
                ButtonCustom(
                  onPressed: () {
                    // Show the bottom sheet when the button is clicked
                    showBottomSheetWidget(
                      context,
                      initialTime: DateTime.now(),
                      onTimeChanged: (DateTime newTime) {
                        // Handle time changes
                        print('New Time Selected: $newTime');
                      },
                      onSave: () {
                        // Handle save action
                        print('Alarm Saved');
                      },
                      snoozeEnabled: true, // Initial snooze value
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: mediaquery.width * .08,
                  ),
                ),
                ButtonCustom(
                  onPressed: () {
                    push(context, AlarmsScreen());
                  },
                  icon: Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: mediaquery.width * .08,
                  ),
                ),
                Gap(mediaquery.width * .05),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime time;

  ClockPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Draw the clock face with a gradient
    _drawClockFace(canvas, center, size.width);

    // Draw hour hand
    double hourAngle = (time.hour % 12 + time.minute / 60) * 30;
    _drawHand(canvas, center, hourAngle, size.width / 3, Colors.black, 8);

    // Draw minute hand
    double minuteAngle = (time.minute + time.second / 60) * 6;
    _drawHand(canvas, center, minuteAngle, size.width / 2.5, Colors.white, 6);

    // Draw second hand with a glow effect
    double secondAngle = time.second * 6;
    _drawHand(canvas, center, secondAngle, size.width / 2, Colors.red, 4,
        isSecondHand: true);

    // Draw clock ticks
    _drawTicks(canvas, center, size.width);
  }

  void _drawClockFace(Canvas canvas, Offset center, double diameter) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.blue.shade300, Colors.blue.shade700],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: diameter / 2))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, diameter / 2, paint);

    // Shadow for clock face
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawCircle(center, diameter / 2, shadowPaint);
  }

  void _drawHand(Canvas canvas, Offset center, double angle, double length,
      Color color, double strokeWidth,
      {bool isSecondHand = false}) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (isSecondHand) {
      paint
        ..color = color.withOpacity(0.8)
        ..strokeWidth = 3;
    }

    double radian = (angle - 90) * pi / 180;
    double endX = center.dx + length * cos(radian);
    double endY = center.dy + length * sin(radian);

    canvas.drawLine(center, Offset(endX, endY), paint);
  }

  void _drawTicks(Canvas canvas, Offset center, double diameter) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..strokeWidth = 2;

    for (int i = 0; i < 60; i++) {
      double angle = i * 6 * pi / 180; // Tick every 6°
      double startX = center.dx + (diameter / 2) * cos(angle);
      double startY = center.dy + (diameter / 2) * sin(angle);
      double endX = center.dx + (diameter / 2.1) * cos(angle);
      double endY = center.dy + (diameter / 2.1) * sin(angle);

      if (i % 5 == 0) {
        // Hour ticks are longer
        endX = center.dx + (diameter / 2.3) * cos(angle);
        endY = center.dy + (diameter / 2.3) * sin(angle);
        paint.color = Colors.black;
        paint.strokeWidth = 3;
      } else {
        paint.color = Colors.black.withOpacity(0.5);
        paint.strokeWidth = 2;
      }

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint to update time
  }
}
