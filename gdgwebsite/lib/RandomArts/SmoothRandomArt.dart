import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';


const googleColors = [gBlue, gRed, gYellow, gGreen];

class SmoothRandomArt extends StatefulWidget {
  const SmoothRandomArt({super.key});

  @override
  State<SmoothRandomArt> createState() => _SmoothRandomArtState();
}

class _SmoothRandomArtState extends State<SmoothRandomArt>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_MovingBlob>? _blobs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // 🔥 faster animation!
    )..repeat();
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

        // Create once with canvas size
        _blobs ??= List.generate(25, (_) => _MovingBlob(size));

        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => CustomPaint(
            size: size,
            painter: _SmoothBlobPainter(_blobs!, _controller.value),
          ),
        );
      },
    );
  }
}

class _MovingBlob {
  final Offset base;
  final Color color;
  final Size size;
  final double phase;

  static final _rand = Random();

  _MovingBlob(Size canvasSize)
      : base = Offset(
          _rand.nextDouble() * canvasSize.width,
          _rand.nextDouble() * canvasSize.height,
        ),
        color = googleColors[_rand.nextInt(googleColors.length)]
            .withOpacity(0.25 + _rand.nextDouble() * 0.2), // subtle blend
        size = Size(
          40 + _rand.nextDouble() * 50,
          40 + _rand.nextDouble() * 50,
        ),
        phase = _rand.nextDouble() * 2 * pi;

  Offset position(double t) {
    final dx = base.dx + 30 * sin(t * 2 * pi + phase);
    final dy = base.dy + 30 * cos(t * 2 * pi + phase);
    return Offset(dx, dy);
  }
}

class _SmoothBlobPainter extends CustomPainter {
  final List<_MovingBlob> blobs;
  final double time;

  _SmoothBlobPainter(this.blobs, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final blob in blobs) {
      paint.color = blob.color;
      final pos = blob.position(time);
      final rect = Rect.fromCenter(center: pos, width: blob.size.width, height: blob.size.height);
      canvas.drawOval(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SmoothBlobPainter oldDelegate) =>
      oldDelegate.time != time;
}