//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

const googleColors = [gBlue, gRed, gYellow, gGreen];

class TriangleMesh extends StatefulWidget {
  const TriangleMesh({super.key});

  @override
  State<TriangleMesh> createState() => _TriangleMeshState();
}

class _TriangleMeshState extends State<TriangleMesh>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_MovingPoint> _points = [];
  final int pointCount = 80;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        setState(() {
          for (final p in _points) {
            p.update();
          }
        });
      })..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        if (_points.isEmpty) {
          final rand = Random();
          _points = List.generate(pointCount, (_) {
            final pos = Offset(
              rand.nextDouble() * size.width,
              rand.nextDouble() * size.height,
            );
            final velocity = Offset(
              rand.nextDouble() * 1.5 - 0.75,
              rand.nextDouble() * 1.5 - 0.75,
            );
            return _MovingPoint(pos, velocity, size);
          });
        }

        return CustomPaint(
          painter: _TriangleMeshPainter(_points),
          size: size,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _MovingPoint {
  Offset pos;
  Offset velocity;
  final Size bounds;

  _MovingPoint(this.pos, this.velocity, this.bounds);

  void update() {
    pos += velocity;

    // Bounce on edges
    if (pos.dx < 0 || pos.dx > bounds.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (pos.dy < 0 || pos.dy > bounds.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}

class _TriangleMeshPainter extends CustomPainter {
  final List<_MovingPoint> points;
  final Paint paintLine = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  _TriangleMeshPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final connections = <Tuple<_MovingPoint, _MovingPoint>>[];
    final threshold = 150 * 150;

    // Connect nearby points
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final a = points[i];
        final b = points[j];
        if ((a.pos - b.pos).distanceSquared < threshold) {
          connections.add(Tuple(a, b));
        }
      }
    }

    for (final line in connections) {
      final index = points.indexOf(line.a);
      paintLine.color = googleColors[index % googleColors.length]
          .withOpacity(0.2 + Random().nextDouble() * 0.3);
      canvas.drawLine(line.a.pos, line.b.pos, paintLine);
    }

    // Optional: Draw dots
    final dotPaint = Paint()..color = Colors.white.withOpacity(0.2);
    for (final p in points) {
      canvas.drawCircle(p.pos, 1.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Simple Tuple class to store 2 connected points
class Tuple<A, B> {
  final A a;
  final B b;
  const Tuple(this.a, this.b);
}
