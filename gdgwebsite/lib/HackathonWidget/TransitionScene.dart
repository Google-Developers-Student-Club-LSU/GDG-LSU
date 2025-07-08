import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Pages/Hackathon.dart';
import 'package:gdgwebsite/Colors.dart';
import 'package:gdgwebsite/HackathonWidget/WarpPainter.dart';

class TransitionScene extends StatefulWidget {
  const TransitionScene({super.key});

  @override
  State<TransitionScene> createState() => _TransitionSceneState();
}

class _TransitionSceneState extends State<TransitionScene> with TickerProviderStateMixin {
  late final AnimationController _warpController;
  late final AnimationController _textController;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    // 1) Warp loop
    _warpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )
      ..addListener(() => setState(() {}))
      ..repeat();

    // 2) Text fade‐in
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _textOpacity = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // start fading the text in after 1 second
    Timer(const Duration(seconds: 1), () {
      _textController.forward();
    });

    // 3) After 3 seconds total, stop warp & navigate
    Timer(const Duration(seconds: 2), () {
      _warpController.stop();
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HackathonPage(),
          transitionDuration: const Duration(milliseconds: 1200),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(
              opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _warpController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Stack(
        children: [
          // full-screen warp
          CustomPaint(
            painter: WarpPainter(time: _warpController.value),
            child: const SizedBox.expand(),
          ),

          // centered, fading text
          FadeTransition(
            opacity: _textOpacity,
            child: const Center(
              child: Text(
                'Welcome to Hackathon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
