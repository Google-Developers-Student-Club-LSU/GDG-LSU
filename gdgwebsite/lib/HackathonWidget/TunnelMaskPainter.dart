
import 'package:flutter/material.dart';

class TunnelMaskPainter extends CustomPainter {
  final double radius;
  TunnelMaskPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final tunnel = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    final screen = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final mask = Path.combine(PathOperation.difference, screen, tunnel);
    canvas.drawPath(mask, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant TunnelMaskPainter oldDelegate) => oldDelegate.radius != radius;
}