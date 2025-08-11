// aurora_background_htmlsafe.dart
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AuroraBackgroundHtmlSafe extends StatefulWidget {
  final List<Color> colors;
  final int blobCount;
  final double speed;
  final double intensity;
  final double scale;
  final bool vignette;

  const AuroraBackgroundHtmlSafe({
    super.key,
    this.colors = const [
      Color(0xFF00FF66),
      Color(0xFF66D1FF),
      Color(0xFFE86FFF),
      Color(0xFF00FFAA),
    ],
    this.blobCount = 5,
    this.speed = 1.0,
    this.intensity = 0.9,
    this.scale = 0.8,
    this.vignette = true,
  });

  @override
  State<AuroraBackgroundHtmlSafe> createState() => _AuroraBackgroundHtmlSafeState();
}

class _AuroraBackgroundHtmlSafeState extends State<AuroraBackgroundHtmlSafe>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late final List<_Blob> _blobs;
  final _rng = math.Random();

  double _timeSec = 0.0;          
  Duration _last = Duration.zero;
  final int _fps = 60;           
  @override
  void initState() {
    super.initState();

    _blobs = List.generate(widget.blobCount, (_) => _Blob(
      baseAngle: _rng.nextDouble() * math.pi * 2,
      baseRadius: ui.lerpDouble(0.15, 0.45, _rng.nextDouble())!,
      amp: ui.lerpDouble(0.08, 0.22, _rng.nextDouble())!,
      freq: ui.lerpDouble(0.25, 0.75, _rng.nextDouble())!,
      phase: _rng.nextDouble() * math.pi * 2,
    ));

    _ticker = createTicker((elapsed) {
      final dt = (elapsed - _last).inMicroseconds / 1e6; // seconds
      _last = elapsed;
      if (dt <= 0) return;

      final maxDt = 1.0 / _fps;
      _timeSec += (dt > maxDt ? maxDt : dt) * widget.speed; // apply speed here
      setState(() {}); // repaint
    });
    _ticker.start();
  }

  @override
  void dispose() { _ticker.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _AuroraHtmlPainter(
          t: _timeSec,                     // pass seconds, never resets
          blobs: _blobs,
          colors: widget.colors,
          intensity: widget.intensity,
          scale: widget.scale,
          vignette: widget.vignette,
        ),
      ),
    );
  }
}


class _Blob {
  final double baseAngle, baseRadius, amp, freq, phase;
  const _Blob({required this.baseAngle, required this.baseRadius, required this.amp, required this.freq, required this.phase});
}

class _AuroraHtmlPainter extends CustomPainter {
  final double t;
  final List<_Blob> blobs;
  final List<Color> colors;
  final double intensity, scale;
  final bool vignette;

  const _AuroraHtmlPainter({
    required this.t,
    required this.blobs,
    required this.colors,
    required this.intensity,
    required this.scale,
    required this.vignette,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final shortest = math.min(size.width, size.height);
    final center = Offset(size.width / 2, size.height / 2);

    // dark base
    final base = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero, Offset(size.width, size.height),
        [const Color(0xFF0B0F12), const Color(0xFF060606)],
      );
    canvas.drawRect(Offset.zero & size, base);

    final time = t / 1000.0;

    for (var i = 0; i < blobs.length; i++) {
      final b = blobs[i];

      final breathing = 1.0 + 0.12 * math.sin((time + b.phase) * (0.7 + b.freq));
      final angle = b.baseAngle + time * (0.1 + b.freq * 0.2);
      final orbitR = (b.baseRadius + b.amp * math.sin(time * (0.6 + b.freq))) * shortest * scale;

      final pos = center + Offset(math.cos(angle) * orbitR, math.sin(angle) * orbitR * 0.75);
      final r = (shortest * (0.28 + 0.22 * math.sin(time * 0.9 + b.phase))) * 0.9 * scale * breathing;

      final c = colors[i % colors.length];
      // No maskFilter, no BlendMode.plus — just layered radial gradients
      final shader = ui.Gradient.radial(
        pos, math.max(1, r),
        [
          c.withOpacity(0.14 * intensity),
          c.withOpacity(0.06 * intensity),
          Colors.transparent,
        ],
        const [0.0, 0.55, 1.0],
      );

      final p = Paint()..shader = shader; // default srcOver
      canvas.drawCircle(pos, r, p);

      // a faint outer halo to mimic softness (HTML-friendly)
      final halo = ui.Gradient.radial(
        pos, r * 1.25,
        [
          c.withOpacity(0.04 * intensity),
          Colors.transparent,
        ],
        const [0.0, 1.0],
      );
      canvas.drawCircle(pos, r * 1.25, Paint()..shader = halo);
    }

    if (vignette) {
      final v = Paint()
        ..shader = ui.Gradient.radial(
          center, shortest * 0.8,
          [Colors.transparent, Colors.black.withOpacity(0.12), Colors.black.withOpacity(0.24)],
          const [0.65, 0.9, 1.0],
        );
      canvas.drawRect(Offset.zero & size, v);
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraHtmlPainter old) => true;
}
