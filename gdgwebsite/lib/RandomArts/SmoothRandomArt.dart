import 'dart:math';
import 'package:flutter/material.dart';

class SpiralDotsArt extends StatefulWidget {
  const SpiralDotsArt({Key? key}) : super(key: key);
  @override
  _SpiralDotsArtState createState() => _SpiralDotsArtState();
}

class _SpiralDotsArtState extends State<SpiralDotsArt>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat();
  }
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        size: Size.infinite,
        painter: _SpiralPainter(_ctrl.value),
      ),
    );
  }
}

class _SpiralPainter extends CustomPainter {
  final double t;
  _SpiralPainter(this.t);
  @override
  void paint(Canvas canvas, Size s) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = s.center(Offset.zero);

    // Increase count and spacing for a larger spiral
    final int totalDots = 1200;
    final double spacing = 0.08;   // increases distance between dots
    final double growth = 8.0;     // how quickly the spiral expands

    for (int i = 0; i < totalDots; i++) {
      final double d = i * spacing;
      final double ang = i * 0.1 + t * 2 * pi;
      final double x = center.dx + cos(ang) * d * growth;
      final double y = center.dy + sin(ang) * d * growth;
      final double alpha = (1 - d / (spacing * totalDots)).clamp(0.0, 1.0);
      paint.color = Colors.primaries[i % Colors.primaries.length].withValues(alpha: alpha * 0.7);
      canvas.drawCircle(Offset(x, y), d * 0.04, paint);
    }
  }
  @override
  bool shouldRepaint(covariant _SpiralPainter old) => old.t != t;
}
