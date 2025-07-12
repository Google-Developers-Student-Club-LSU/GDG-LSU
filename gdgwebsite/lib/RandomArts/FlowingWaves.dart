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


const waveColors = [gBlue, gRed, gYellow, gGreen];

class FlowingWaves extends StatefulWidget {
  const FlowingWaves({super.key});

  @override
  State<FlowingWaves> createState() => _FlowingWavesState();
}

class _FlowingWavesState extends State<FlowingWaves>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..repeat(min: 0, max: 2 * pi, period: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        painter: _WavePainter(_controller.value),
        size: Size.infinite,
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double time;
  _WavePainter(this.time);

  final int waveCount = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < waveCount; i++) {
      paint.color = waveColors[i % waveColors.length];

      final path = Path();
      final frequency = 2 + i;
      final amplitude = size.height * 0.05 * (1 + i); 
      final yOffset = size.height * 0.2 * (i + 1); 

      for (double x = 0; x <= size.width; x++) {
        final wave = sin((x / size.width * frequency * 2 * pi) + time);
        final y = yOffset + wave * amplitude;
        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) =>
      oldDelegate.time != time;
}
