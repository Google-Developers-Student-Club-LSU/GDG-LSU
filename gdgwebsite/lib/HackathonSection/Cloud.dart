import 'dart:math' as math;
import 'package:flutter/material.dart';

class FloatingCloud extends StatefulWidget {
  final double width;
  final double height;
  final Duration duration;
  final Color color;
  final double shadowBlur;
  final Color shadowColor;
  final double? amplitude;

  /// Controls how “puffy” the cloud gets (0..1)
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
  late final RRect _bodyEllipse; // main capsule-ish body

  @override
  void initState() {
    super.initState();
    final rand = math.Random();

    _phaseOffset = rand.nextDouble() * 2 * math.pi;
    _amp = widget.amplitude ?? (4 + rand.nextDouble() * 6);

    // —— Constrained cloud generation —— //
    // 1) Choose 5–7 lobes, evenly spaced with jitter
    final puffCount = 5 + rand.nextInt(3);

    // horizontal band where cloud lives
    final left = widget.width * 0.12;
    final right = widget.width * 0.88;
    final bandWidth = right - left;

    // vertical band for puff centers (upper half, gentle jitter)
    final yBase = widget.height * 0.55;
    final yJitter = widget.height * 0.10;

    // radius range (kept reasonable)
    final rMin = widget.height * 0.22;
    final rMax = widget.height * 0.36;

    // mild “puffiness” modulation
    final puffiness = widget.puffiness.clamp(0.0, 1.0);
    final jitterX = (bandWidth / puffCount) * (0.15 + 0.25 * puffiness);
    final jitterR = (rMax - rMin) * (0.25 + 0.5 * puffiness);

    _centers = [];
    _radii = [];

    for (int i = 0; i < puffCount; i++) {
      final t = puffCount == 1 ? 0.5 : i / (puffCount - 1);
      // base even spacing
      double cx = left + t * bandWidth;
      // small horizontal jitter, but clamp to band
      cx += (rand.nextDouble() * 2 - 1) * jitterX;
      cx = cx.clamp(left, right);

      // y with small jitter
      final cy = yBase + (rand.nextDouble() * 2 - 1) * yJitter;

      // radius with smooth-ish variation using sin + jitter
      final baseR = rMin + (0.5 + 0.5 * math.sin(t * math.pi)) * (rMax - rMin);
      final r = (baseR + (rand.nextDouble() * 2 - 1) * jitterR).clamp(rMin, rMax);

      _centers.add(Offset(cx, cy));
      _radii.add(r);
    }

    // 2) Ensure overlap by softly pulling neighbors together if gaps are too large
    for (int i = 1; i < _centers.length; i++) {
      final prev = _centers[i - 1];
      final curr = _centers[i];
      final dist = (curr.dx - prev.dx).abs();
      final maxGap = (_radii[i - 1] + _radii[i]) * 0.85; // enforce ~15% overlap
      if (dist > maxGap) {
        final mid = (prev.dx + curr.dx) / 2;
        _centers[i - 1] = Offset(mid - maxGap / 2, _centers[i - 1].dy);
        _centers[i] = Offset(mid + maxGap / 2, _centers[i].dy);
      }
    }

    // 3) Add a main body capsule to unify silhouette
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

    // body height anchored around 60–75% area
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
            painter: _ConstrainedCloudPainter(
              color: widget.color,
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

class _ConstrainedCloudPainter extends CustomPainter {
  final Color color;
  final double shadowBlur;
  final Color shadowColor;
  final List<Offset> centers;
  final List<double> radii;
  final RRect bodyEllipse;

  _ConstrainedCloudPainter({
    required this.color,
    required this.shadowBlur,
    required this.shadowColor,
    required this.centers,
    required this.radii,
    required this.bodyEllipse,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..isAntiAlias = true;

    // Soft shadow
    if (shadowBlur > 0) {
      final shadowPaint = Paint()
        ..color = shadowColor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);
      _drawCloud(canvas, size, shadowPaint, dy: 2);
    }

    _drawCloud(canvas, size, paint);
  }

  void _drawCloud(Canvas canvas, Size size, Paint paint, {double dy = 0}) {
    final path = Path();

    // Main body capsule
    path.addRRect(bodyEllipse.shift(Offset(0, dy)));

    // Add puff ovals
    for (int i = 0; i < centers.length; i++) {
      path.addOval(Rect.fromCircle(
        center: centers[i] + Offset(0, dy),
        radius: radii[i],
      ));
    }

    // Flat-ish base to ensure nice silhouette
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
      Rect.fromLTWH(
        minX,
        baseTop + dy,
        (maxX - minX),
        size.height * 0.26,
      ),
      Radius.circular(size.height * 0.12),
    );
    path.addRRect(baseRect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ConstrainedCloudPainter oldDelegate) => false;
}
