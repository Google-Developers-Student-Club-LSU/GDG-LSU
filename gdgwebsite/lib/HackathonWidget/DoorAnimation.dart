import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gdgwebsite/HackathonWidget/DoorWidget.dart';
import 'package:gdgwebsite/HackathonWidget/TransitionScene.dart';
import 'package:gdgwebsite/HackathonWidget/TunnelMaskPainter.dart';
import 'package:gdgwebsite/HackathonWidget/WarpPainter.dart';
import 'package:gdgwebsite/Pages/Hackathon.dart';

class DoorAnimation extends StatefulWidget {
  const DoorAnimation({super.key});
  @override
  State<DoorAnimation> createState() => _DoorAnimationState();
}

class _DoorAnimationState extends State<DoorAnimation> with TickerProviderStateMixin {
  // controllers
  late AnimationController _doorController,
      _warpController,
      _tunnelController,
      _zoomController,
      _pressController,
      _walkController;

  // tweens
  late Animation<double> _leftDoorAngle,
      _rightDoorAngle,
      _tunnelRadius,
      _zoomAnimation,
      _pressAnimation,
      _walkZ;

  bool showWarp = false;
  bool showTunnel = false;
  final double doorWidth = 150, doorHeight = 300;

  @override
  void initState() {
    super.initState();

    // 1) doors
    _doorController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _leftDoorAngle = Tween(begin: 0.0, end: -pi/2).animate(
      CurvedAnimation(parent: _doorController, curve: Curves.easeInOut),
    );
    _rightDoorAngle = Tween(begin: 0.0, end: pi/2).animate(
      CurvedAnimation(parent: _doorController, curve: Curves.easeInOut),
    );

    // 2) walk-through
    _walkController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _walkZ = Tween(begin: 0.0, end: -300.0).animate(
      CurvedAnimation(parent: _walkController, curve: Curves.easeInOut),
    );

    // 3) zoom into warp
    _zoomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _zoomAnimation = Tween(begin: 1.0, end: 3.0).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );

    // 4) warp painter
    _warpController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() => setState(() {}));

    // 5) tunnel painter
    _tunnelController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() => setState(() {}));
    _tunnelRadius = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _tunnelController, curve: Curves.easeOutCubic),
    );

    // 6) little “press” bump
    _pressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _pressAnimation = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );
  }

  Future<void> _startSequence() async {
    // ensure press-down scale reverses
    await _pressController.reverse();

    // 1) swing doors open
    await _doorController.forward();

    // 2) walk forward through doorway
    await _walkController.forward();

    // 3) zoom in & start warp
    await _zoomController.forward();
    setState(() => showWarp = true);
    _warpController.repeat();

    // 4) after a beat, reveal tunnel
    await Future.delayed(const Duration(seconds: 0));
    setState(() => showTunnel = true);
    await _tunnelController.forward();

    // 5) stop warp & navigate
    _warpController.stop();
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) => const TransitionScene(),
      transitionDuration: const Duration(milliseconds: 1200),
      transitionsBuilder: (_, anim, __, child) {
        return FadeTransition(opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut), child: child);
      },
    ));
  }

  @override
  void dispose() {
    _doorController.dispose();
    _walkController.dispose();
    _zoomController.dispose();
    _warpController.dispose();
    _tunnelController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final tunnelRadius = screenSize.longestSide * _tunnelRadius.value;

    return AnimatedBuilder(
      animation: _walkZ,
      builder: (context, child) {
        // tiny perspective + Z translation
        final cam = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(0, 0, _walkZ.value);
        return Transform(alignment: Alignment.center, transform: cam, child: child);
      },
        child: ScaleTransition(
          scale: _pressAnimation,
          alignment: Alignment.center,
          child: ScaleTransition(
            scale: _zoomAnimation,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (showWarp)
                  CustomPaint(
                    painter: WarpPainter(time: _warpController.value),
                    child: const SizedBox.expand(),
                  ),
                if (showTunnel)
                  CustomPaint(
                    painter: TunnelMaskPainter(radius: tunnelRadius),
                    child: const SizedBox.expand(),
                  ),
                if (!showWarp && !showTunnel)
                  SizedBox(
                    width: doorWidth * 2,
                    height: doorHeight,
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedBuilder(
                          animation: _leftDoorAngle,
                          builder: (_, __) => Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_leftDoorAngle.value),
                            child: DoorWidget(isLeft: true),
                          ),
                        ),
                      ),
                      InkWell(
                      onTapDown: (_) => _pressController.forward(),
                      onTapUp: (_) => _startSequence(),
                      onTapCancel: () => _pressController.reverse(),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedBuilder(
                            animation: _rightDoorAngle,
                            builder: (_, __) => Transform(
                              alignment: Alignment.centerRight,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_rightDoorAngle.value),
                              child: DoorWidget(isLeft: false),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
              ],
            ),
          ),
        ),
      
    );
  }
}
