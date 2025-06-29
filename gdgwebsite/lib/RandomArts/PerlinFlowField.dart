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

class PerlinFlowField extends StatefulWidget {
  const PerlinFlowField({super.key});

  @override
  State<PerlinFlowField> createState() => _PerlinFlowFieldState();
}

class _PerlinFlowFieldState extends State<PerlinFlowField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_FlowParticle>? _particles;
  Size? _canvasSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() {
        if (_canvasSize == null || _particles == null) return;
        for (final p in _particles!) {
          p.update(_canvasSize!);
        }
        setState(() {}); // trigger repaint
      })
      ..repeat(min: 0, max: 1, period: const Duration(milliseconds: 16));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
        if (_canvasSize == null || _canvasSize != canvasSize) {
          _canvasSize = canvasSize;
          _particles = List.generate(
            700,
            (_) => _FlowParticle(canvasSize),
          );
        }

        return CustomPaint(
          size: canvasSize,
          painter: _FlowFieldPainter(_particles!),
        );
      },
    );
  }
}

class _FlowParticle {
  Offset pos;
  Offset velocity = Offset.zero;
  final Color color;
  static final _rand = Random();

  _FlowParticle(Size size)
      : pos = Offset(
          _rand.nextDouble() * size.width,
          _rand.nextDouble() * size.height,
        ),
        color = googleColors[_rand.nextInt(googleColors.length)].withValues(alpha: 0.5);

  void update(Size bounds) {
    final angle = _perlinNoise(pos.dx * 0.002, pos.dy * 0.002) * pi * 4;
    final direction = Offset(cos(angle), sin(angle));

    // ✅ Amplitude scales with canvas height
    final amplitude = bounds.height * 0.001; 
    velocity += direction * amplitude;
    velocity *= 0.2;
    pos += velocity;

    // Wrap around screen
    if (pos.dx < 0) pos = Offset(bounds.width, pos.dy);
    if (pos.dx > bounds.width) pos = Offset(0, pos.dy);
    if (pos.dy < 0) pos = Offset(pos.dx, bounds.height);
    if (pos.dy > bounds.height) pos = Offset(pos.dx, 0);
  }

  static double _perlinNoise(double x, double y) {
    // Fake Perlin-style flow field (simple sine/cosine blend)
    return (sin(x * 2 * pi) + cos(y * 2 * pi)) * 0.5 + 0.5;
  }
}

class _FlowFieldPainter extends CustomPainter {
  final List<_FlowParticle> particles;

  _FlowFieldPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;

    for (final p in particles) {
      paint.color = p.color;
      canvas.drawCircle(p.pos, 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
