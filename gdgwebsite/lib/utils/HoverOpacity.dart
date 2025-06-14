import 'package:flutter/material.dart';

class HoverOpacity extends StatefulWidget {
  final Widget child;
  final double hoverOpacity;
  final Duration duration;

  const HoverOpacity({
    super.key,
    required this.child,
    this.hoverOpacity = 0.7,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverOpacity> createState() => _HoverOpacityState();
}

class _HoverOpacityState extends State<HoverOpacity> {
  bool _hovering = false; 
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _hovering = true),
      onExit: (event) => setState(() => _hovering = false),
      child: AnimatedOpacity(opacity: _hovering ? widget.hoverOpacity : 1.0, 
      duration: widget.duration,
      child: widget.child
      ),
    );
  }
}