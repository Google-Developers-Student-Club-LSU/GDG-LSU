
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class WarpPainter extends CustomPainter {
  final double time;
  final int starCount = 200;
  final Random random = Random();

  WarpPainter({required this.time});

  static const List<Color> warpColors = [
    gBlue,
    gGreen,
    gRed,
    gYellow
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()..strokeCap = StrokeCap.round;

    for (int i = 0; i < starCount; i++) {
      paint
        ..color = warpColors[random.nextInt(warpColors.length)]
        ..strokeWidth = 1 + random.nextDouble() * 2;
      double angle = random.nextDouble() * 2 * pi;
      double radius = random.nextDouble() * size.shortestSide * 0.4;
      double length = time * 900 + random.nextDouble() * 20;

      final start = Offset(center.dx + cos(angle) * radius,
          center.dy + sin(angle) * radius);
      final end = Offset(
          center.dx + cos(angle) * (radius + length),
          center.dy + sin(angle) * (radius + length));
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
