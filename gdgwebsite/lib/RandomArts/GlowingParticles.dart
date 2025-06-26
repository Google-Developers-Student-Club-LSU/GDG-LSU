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
class GlowingParticles extends StatefulWidget {
  const GlowingParticles({super.key});

  @override
  State<GlowingParticles> createState() => _GlowingParticlesState();
}

class _GlowingParticlesState extends State<GlowingParticles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_GlowingDot>? _dots;
  Size? _canvasSize;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
        if (_dots != null && _canvasSize != null) {
          for (final dot in _dots!) {
            dot.update(_canvasSize!);
          }
          setState(() {});
        }
      });
    _controller.repeat();
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
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _canvasSize = size;

        _dots ??= List.generate(120, (_) => _GlowingDot(size));

        return CustomPaint(
          painter: _GlowingPainter(_dots!),
          size: size,
        );
      },
    );
  }
}

class _GlowingDot {
  Offset pos;
  Offset velocity;
  double radius;
  final Color color;
  static final _rand = Random();

  _GlowingDot(Size size)
      : pos = Offset(
          _rand.nextDouble() * size.width,
          _rand.nextDouble() * size.height,
        ),
        velocity = Offset(
          (_rand.nextDouble() - 0.5) * 0.5,
          (_rand.nextDouble() - 0.5) * 0.5,
        ),
        radius = 1.0 + _rand.nextDouble() * 2.0,
       color = googleColors[_rand.nextInt(googleColors.length)];


  void update(Size size) {
    pos += velocity;
    if (pos.dx < 0 || pos.dx > size.width) velocity = Offset(-velocity.dx, velocity.dy);
    if (pos.dy < 0 || pos.dy > size.height) velocity = Offset(velocity.dx, -velocity.dy);
  }
}

class _GlowingPainter extends CustomPainter {
  final List<_GlowingDot> dots;

  _GlowingPainter(this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal,2)
      ..style = PaintingStyle.fill;

    for (final dot in dots) {
      paint.color = dot.color;
      canvas.drawCircle(dot.pos, dot.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
