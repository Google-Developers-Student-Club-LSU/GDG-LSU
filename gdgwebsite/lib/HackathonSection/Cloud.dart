import 'dart:math' as math;
import 'package:flutter/material.dart';

class FloatingCloud extends StatefulWidget {
  final double width;
  final double height;
  final Duration duration;
  final Color color;          // base tint (still used)
  final double shadowBlur;
  final Color shadowColor;
  final double? amplitude;
  /// 0..1 – controls number/size variation of puff lobes
  final double puffiness;

  const FloatingCloud({
    super.key,
    this.width = 220,
    this.height = 120,
    this.duration = const Duration(seconds: 5),
    this.color = const Color(0xFFFFFFFF),
    this.shadowBlur = 16,
    this.shadowColor = const Color(0x22000000),
    this.amplitude,
    this.puffiness = 0.6,
  });

  @override
  State<FloatingCloud> createState() => _FloatingCloudState();
}

class _FloatingCloudState extends State<FloatingCloud>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _t;
  late final double _phaseOffset;
  late final double _amp;

  late final List<Offset> _centers;
  late final List<double> _radii;
  late final RRect _bodyEllipse;

  @override
  void initState() {
    super.initState();
    final rand = math.Random();

    _phaseOffset = rand.nextDouble() * 2 * math.pi;
    _amp = widget.amplitude ?? (4 + rand.nextDouble() * 6);

    // ---- Generate fluffy lobe layout ----
    final puffCount = 5 + rand.nextInt(3);

    final left = widget.width * 0.12;
    final right = widget.width * 0.88;
    final bandWidth = right - left;

    final yBase = widget.height * 0.55;
    final yJitter = widget.height * 0.10;

    final rMin = widget.height * 0.22;
    final rMax = widget.height * 0.36;

    final puffiness = widget.puffiness.clamp(0.0, 1.0);
    final jitterX = (bandWidth / puffCount) * (0.15 + 0.25 * puffiness);
    final jitterR = (rMax - rMin) * (0.25 + 0.5 * puffiness);

    _centers = [];
    _radii = [];

    for (int i = 0; i < puffCount; i++) {
      final t = puffCount == 1 ? 0.5 : i / (puffCount - 1);
      double cx = left + t * bandWidth;
      cx += (rand.nextDouble() * 2 - 1) * jitterX;
      cx = cx.clamp(left, right);
      final cy = yBase + (rand.nextDouble() * 2 - 1) * yJitter;
      final baseR = rMin + (0.5 + 0.5 * math.sin(t * math.pi)) * (rMax - rMin);
      final r = (baseR + (rand.nextDouble() * 2 - 1) * jitterR).clamp(rMin, rMax);
      _centers.add(Offset(cx, cy));
      _radii.add(r);
    }

    // ensure overlap
    for (int i = 1; i < _centers.length; i++) {
      final prev = _centers[i - 1];
      final curr = _centers[i];
      final dist = (curr.dx - prev.dx).abs();
      final maxGap = (_radii[i - 1] + _radii[i]) * 0.85;
      if (dist > maxGap) {
        final mid = (prev.dx + curr.dx) / 2;
        _centers[i - 1] = Offset(mid - maxGap / 2, _centers[i - 1].dy);
        _centers[i] = Offset(mid + maxGap / 2, _centers[i].dy);
      }
    }

    // main unifying capsule
    final minX = _centers
        .asMap()
        .entries
        .map((e) => e.value.dx - _radii[e.key])
        .reduce(math.min);
    final maxX = _centers
        .asMap()
        .entries
        .map((e) => e.value.dx + _radii[e.key])
        .reduce(math.max);

    final bodyTop = widget.height * 0.50;
    final bodyHeight = widget.height * (0.28 + 0.12 * puffiness);
    final bodyRect = Rect.fromLTWH(
      minX,
      bodyTop,
      (maxX - minX),
      bodyHeight,
    );
    _bodyEllipse = RRect.fromRectXY(bodyRect, bodyHeight * 0.45, bodyHeight * 0.45);

    _c = AnimationController(vsync: this, duration: widget.duration)..repeat();
    _t = CurvedAnimation(parent: _c, curve: Curves.linear);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _t,
      builder: (_, __) {
        final bob = math.sin((_t.value * 2 * math.pi) + _phaseOffset) * _amp;
        final drift = math.cos((_t.value * 2 * math.pi) + _phaseOffset) * (_amp * 0.6);

        return Transform.translate(
          offset: Offset(drift, bob),
          child: CustomPaint(
            size: Size(widget.width, widget.height),
            painter: _FluffyCloudPainter(
              baseColor: widget.color,
              shadowBlur: widget.shadowBlur,
              shadowColor: widget.shadowColor,
              centers: _centers,
              radii: _radii,
              bodyEllipse: _bodyEllipse,
            ),
          ),
        );
      },
    );
  }
}

class _FluffyCloudPainter extends CustomPainter {
  final Color baseColor;
  final double shadowBlur;
  final Color shadowColor;
  final List<Offset> centers;
  final List<double> radii;
  final RRect bodyEllipse;

  _FluffyCloudPainter({
    required this.baseColor,
    required this.shadowBlur,
    required this.shadowColor,
    required this.centers,
    required this.radii,
    required this.bodyEllipse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Build union path
    final path = Path()..addRRect(bodyEllipse);
    for (int i = 0; i < centers.length; i++) {
      path.addOval(Rect.fromCircle(center: centers[i], radius: radii[i]));
    }

    // Add a flat-ish base to keep silhouette grounded
    final minX = centers
        .asMap()
        .entries
        .map((e) => e.value.dx - radii[e.key])
        .reduce(math.min);
    final maxX = centers
        .asMap()
        .entries
        .map((e) => e.value.dx + radii[e.key])
        .reduce(math.max);
    final baseTop = size.height * 0.68;
    final baseRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(minX, baseTop, (maxX - minX), size.height * 0.26),
      Radius.circular(size.height * 0.12),
    );
    path.addRRect(baseRect);

    // ---- 1) Outer soft halo (feathered rim) ----
    final haloPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.12
      ..color = Colors.white.withOpacity(0.22)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.height * 0.12);
    canvas.drawPath(path, haloPaint);

    // ---- 2) Drop shadow (below) for depth ----
    if (shadowBlur > 0) {
      final shadowPaint = Paint()
        ..color = shadowColor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);
      canvas.save();
      canvas.translate(0, 2); // slight y-offset
      canvas.drawPath(path, shadowPaint);
      canvas.restore();
    }

    // ---- 3) Creamy fill (top warm → bottom cool) ----
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.95),                         // bright top
          Color.alphaBlend(const Color(0xFFEFF7FF), baseColor)     // cool base
              .withOpacity(0.90),
          const Color(0xFFE3F1FF).withOpacity(0.85),               // subtle blue
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Offset.zero & size);
    canvas.drawPath(path, fillPaint);

    // ---- 4) Inner shade near the base (adds puff volume) ----
    canvas.save();
    canvas.clipPath(path);
    final shadePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.black.withOpacity(0.06),
          Colors.black.withOpacity(0.10),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Offset(0, size.height * 0.35) &
          Size(size.width, size.height * 0.7));
    canvas.drawRect(Offset.zero & size, shadePaint);
    canvas.restore();

    // ---- 5) Small per-lobe highlights (sparkly puff caps) ----
    for (int i = 0; i < centers.length; i++) {
      final c = centers[i] + const Offset(-4, -6); // top-left offset
      final r = radii[i] * 0.85;
      final highlight = Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            Colors.white.withOpacity(0.30),
            Colors.white.withOpacity(0.00),
          ],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: c, radius: r));
      canvas.drawCircle(c, r, highlight);
    }

    // ---- 6) Soft top rim light to sell fluffiness ----
    final rimPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 0.018
      ..color = Colors.white.withOpacity(0.75)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.height * 0.02);
    // Clip to top half so rim light doesn’t appear at the bottom
    final topClip = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.6));
    canvas.save();
    canvas.clipPath(topClip);
    canvas.drawPath(path, rimPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _FluffyCloudPainter old) {
    // Only re-generate if layout changes; animation comes from Transform/parent.
    return old.baseColor != baseColor ||
        old.shadowBlur != shadowBlur ||
        old.shadowColor != shadowColor ||
        old.bodyEllipse != bodyEllipse ||
        old.centers.length != centers.length;
  }
}
