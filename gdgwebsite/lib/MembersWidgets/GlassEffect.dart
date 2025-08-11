import 'dart:ui';
import 'package:flutter/material.dart';

class GlassEffect extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blurSigmaX;
  final double blurSigmaY;
  final BoxConstraints constraints;
  final Gradient gradient;
  final Color borderColor;
  final double borderWidth;
  final List<BoxShadow> boxShadows;

  const GlassEffect({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 12,
    this.blurSigmaX = 12,
    this.blurSigmaY = 12,
    this.constraints = const BoxConstraints(
      minWidth: 72,
      minHeight: 64,
    ),
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x3800FF66), 
        Color(0x141F3D2C), 
        Color(0x3800FF66),
      ],
    ),
    this.borderColor = const Color(0x591F3D2C), // withValues(alpha: .35)
    this.borderWidth = 1,
    this.boxShadows = const [
      BoxShadow(
        color: Color(0x401F3D2C), 
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
      BoxShadow(
        color: Color(0x1F87CEEB), 
        blurRadius: 20,
        spreadRadius: 1,
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurSigmaX,
                  sigmaY: blurSigmaY,
                ),
                child: const SizedBox(),
              ),
            ),
            Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: gradient,
                border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                ),
                boxShadow: boxShadows,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
