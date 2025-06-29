import 'dart:math';
import 'package:flutter/material.dart';

class MagnetismField extends StatefulWidget {
  const MagnetismField({super.key});
  @override
  _MagnetismFieldState createState() => _MagnetismFieldState();
}

class _MagnetismFieldState extends State<MagnetismField>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  Offset _touch = const Offset(-9999, -9999);
  final int _count = 1000;
  late List<_Dot> _dots;
  Size? _size;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(hours: 1))
      ..addListener(() {
        if (_size == null) return;
        for (var d in _dots) d.update(_touch, _size!);
        setState(() {});
      })
      ..repeat();
    _dots = [];
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return LayoutBuilder(builder: (context, constraints) {
      final s = Size(constraints.maxWidth, constraints.maxHeight);
      if (_size == null || _size != s) {
        _size = s;
        _dots = List.generate(_count, (i) => _Dot(_size!));
      }

      return Listener(
        onPointerHover: (e) => setState(() => _touch = e.localPosition),
        onPointerDown: (e) => setState(() => _touch = e.localPosition),
        onPointerMove: (e) => setState(() => _touch = e.localPosition),
        onPointerUp: (_) => setState(() => _touch = const Offset(-9999, -9999)),
        child: CustomPaint(size: s, painter: _MagneticPainter(_dots)),
      );
    });
  }
}

class _Dot {
  Offset pos;
  Offset vel = Offset.zero;
  final double size;
  final Color color;
  static final _rand = Random();

  _Dot(Size s)
      : pos = Offset(_rand.nextDouble() * s.width, _rand.nextDouble() * s.height),
        size = _rand.nextDouble() * 2 + 1,
        color = Colors.primaries[_rand.nextInt(Colors.primaries.length)]
            .withValues(alpha: .4);

  void update(Offset touch, Size s) {
    final dir = pos - touch;
    final dist2 = dir.distanceSquared;
    const radius = 120 * 120;

    if (dist2 < radius) {
      final force = dir / sqrt(dist2) * (1 - sqrt(dist2) / 120) * 3;
      vel = (vel + force) * 0.9;
    } else {
      vel = vel * 0.92 +
          Offset((_rand.nextDouble() - .5) * .2, (_rand.nextDouble() - .5) * .2);
    }

    pos += vel;
    if (pos.dx < 0) pos = Offset(s.width, pos.dy);
    if (pos.dx > s.width) pos = const Offset(0, 0) + Offset(0, pos.dy);
    if (pos.dy < 0) pos = Offset(pos.dx, s.height);
    if (pos.dy > s.height) pos = Offset(pos.dx, 0);
  }
}

class _MagneticPainter extends CustomPainter {
  final List<_Dot> dots;
  _MagneticPainter(this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var d in dots) {
      paint.color = d.color;
      canvas.drawCircle(d.pos, d.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _) => true;
}
