// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Author: Dina Taing
//
// Frosted-glass countdown rectangles.
// Usage: TimeRect(targetTime: DateTime.parse("2025-11-07 18:00:00"))

import 'dart:async';
import 'dart:ui'; // for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class TimeRect extends StatefulWidget {
  final DateTime targetTime;

  const TimeRect({super.key, required this.targetTime});

  @override
  State<TimeRect> createState() => _TimeRectState();
}

class _TimeRectState extends State<TimeRect> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    final diff = widget.targetTime.difference(now);
    if (!mounted) return;
    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
      if (diff.isNegative) {
        // Stop ticking after we hit zero
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<Widget> _buildTimeBox(String number, String label) {
    return [
      _GlassBox(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          letterSpacing: 0.3,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    final sDays = days.toString().padLeft(2, '0');
    final sHours = hours.toString().padLeft(2, '0');
    final sMinutes = minutes.toString().padLeft(2, '0');
    final sSeconds = seconds.toString().padLeft(2, '0');

     final narrow = MediaQuery.of(context).size.width < 650;
    String lbl(String base, int n) => n == 1 ? base : '${base}s';
    final spacing = narrow ? 10.0 : 30.0 ;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(mainAxisSize: MainAxisSize.min, children: _buildTimeBox(sDays, lbl('day', days))),
             SizedBox(width: spacing),
            Column(mainAxisSize: MainAxisSize.min, children: _buildTimeBox(sHours, lbl('hr', hours))),
             SizedBox(width: spacing),
            Column(mainAxisSize: MainAxisSize.min, children: _buildTimeBox(sMinutes, lbl('min', minutes))),
             SizedBox(width: spacing),
            Column(mainAxisSize: MainAxisSize.min, children: _buildTimeBox(sSeconds, lbl('sec', seconds))),
          ],
        ),
      
);

  }
}

class _GlassBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blurSigma;

  const _GlassBox({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 12,
    this.blurSigma = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 72,   
        minHeight: 64,  
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: const SizedBox(),
              ),
            ),
            Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                  Color(0xFF00FF66).withValues(alpha: .22),
                   Color(0xFF1F3D2C).withValues(alpha: .08),
                  Color(0xFF00FF66).withValues(alpha: .22),
                  ],
                ),
                border: Border.all(
                  color: Color(0xFF1F3D2C).withValues(alpha: .35),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color:Color(0xFF1F3D2C).withValues(alpha: .25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: const Color(0xFF87CEEB).withValues(alpha: .12),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
// Color(0xFF1F3D2C)