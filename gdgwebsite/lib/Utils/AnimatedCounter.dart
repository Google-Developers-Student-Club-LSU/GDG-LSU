//
//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Authors: Dina Taing
//

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class AnimatedCounter extends StatefulWidget {
  final int targetNumber;
  final Duration duration;
  final TextStyle? textStyle;
  final Curve curve;
  final int startNumber;

  const AnimatedCounter({
    super.key,
    required this.targetNumber,
    this.startNumber = 0,
    this.duration = const Duration(milliseconds: 800),
    this.textStyle,
    this.curve = Curves.easeOut,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = IntTween(
      begin: widget.startNumber,
      end: widget.targetNumber,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetNumber != widget.targetNumber) {
      _animation = IntTween(
        begin: _animation.value,
        end: widget.targetNumber,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Text(
          '${_animation.value}',
          style: StandardText.copyWith(fontWeight: FontWeight.w500),
        );
      },
    );
  }
}
