
import 'package:flutter/material.dart';

class HoverExpand extends StatefulWidget {
  final Widget child;
  final double scaleFactor;
  final Duration duration; 

    const HoverExpand({
    super.key,
    required this.child,
    this.scaleFactor = 1.05,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverExpand> createState() => _HoverExpandState();
}

class _HoverExpandState extends State<HoverExpand> {
  
  bool _hovering = false ;

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (event) => setState(() => _hovering = true),
      onExit: (event) => setState(() => _hovering = false) ,
      child: AnimatedScale(
        scale: _hovering ? widget.scaleFactor : 1.0, 
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}