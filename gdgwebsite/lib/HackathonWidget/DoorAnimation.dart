import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gdgwebsite/HackathonWidget/DoorWidget.dart';
import 'package:gdgwebsite/HackathonWidget/TunnelMaskPainter.dart';
import 'package:gdgwebsite/HackathonWidget/WarpPainter.dart';
import 'package:gdgwebsite/Pages/Hackathon.dart';

class DoorAnimation extends StatefulWidget {
  const DoorAnimation({super.key});

  @override
  State<DoorAnimation> createState() => _DoorAnimationState();
}

class _DoorAnimationState extends State<DoorAnimation> with TickerProviderStateMixin {
  late AnimationController _doorController;
  late AnimationController _warpController;
  late AnimationController _tunnelController;
  late AnimationController _zoomController;

  // NEW: press effect controller
  late AnimationController _pressController;
  late Animation<double> _pressAnimation;

  late Animation<double> _leftDoorAngle;
  late Animation<double> _rightDoorAngle;
  late Animation<double> _tunnelRadius;
  late Animation<double> _zoomAnimation;

  final double doorWidth = 150;
  final double doorHeight = 300;

  bool showWarp = false;
  bool showTunnel = false;

  @override
  void initState() {
    super.initState();

    // door‐opening, warp, tunnel & zoom controllers unchanged
    _doorController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _warpController = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..addListener(() => setState(() {}));
    _tunnelController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(() => setState(() {}));
    _zoomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    // NEW: tiny “press” expand
    _pressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _pressAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut)
    );

    // your existing tweens
    _leftDoorAngle = Tween<double>(begin: 0, end: -pi / 2).animate(
      CurvedAnimation(parent: _doorController, curve: Curves.easeInOut),
    );
    _rightDoorAngle = Tween<double>(begin: 0, end: pi / 2).animate(
      CurvedAnimation(parent: _doorController, curve: Curves.easeInOut),
    );
    _tunnelRadius = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _tunnelController, curve: Curves.easeOutCubic),
    );
    _zoomAnimation = Tween<double>(begin: 1.0, end: 3.0).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );
  }

  Future<void> _startSequence() async {
    // 1) run your warp‐zoom
    await _zoomController.forward();

    // 2) open doors
    await _doorController.forward();

    // 3) reveal warp
    setState(() => showWarp = true);
    _warpController.repeat();

    // 4) after a bit, reveal tunnel
    await Future.delayed(const Duration(seconds: 3));
    setState(() => showTunnel = true);
    await _tunnelController.forward();

    // 5) stop warp & navigate
    _warpController.stop();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HackathonPage(),
        transitionDuration: const Duration(milliseconds: 1200),
        transitionsBuilder: (_, animation, __, child) {
          final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return FadeTransition(opacity: fade, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _doorController.dispose();
    _warpController.dispose();
    _tunnelController.dispose();
    _zoomController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final tunnelRadius = screenSize.longestSide * _tunnelRadius.value;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InkWell(
          // start the whole sequence on tap
          onTap: _startSequence,
          // press‐in expands slightly
          onTapDown: (_) => _pressController.forward(),
          onTapUp: (_) => _pressController.reverse(),
          onTapCancel: () => _pressController.reverse(),

          child: ScaleTransition(
            scale: _pressAnimation,           // 1) press effect
            child: ScaleTransition(
              scale: _zoomAnimation,          // 2) your warp zoom
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (showWarp)
                    CustomPaint(
                      painter: WarpPainter(time: _warpController.value),
                      size: Size.infinite,
                    ),
                  if (showTunnel)
                    CustomPaint(
                      painter: TunnelMaskPainter(radius: tunnelRadius),
                      size: Size.infinite,
                    ),
                  if (!showWarp && !showTunnel)
                    SizedBox(
                      width: doorWidth * 2,
                      height: doorHeight,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedBuilder(
                              animation: _leftDoorAngle,
                              builder: (_, __) => Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(_leftDoorAngle.value),
                                child: Doorwidget(isLeft: true),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedBuilder(
                              animation: _rightDoorAngle,
                              builder: (_, __) => Transform(
                                alignment: Alignment.centerRight,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(_rightDoorAngle.value),
                                child: Doorwidget(isLeft: false),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
