//
// Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0
// International License https://creativecommons.org/licenses/by-nc-sa/4.0/
// Authors: Dina Taing
//

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class CircleImageContainer extends StatelessWidget {
  final double size;
  final String imagePath;
  final double borderWidth;

  const CircleImageContainer({
    Key? key,
    required this.imagePath,
    this.size = 100,
    this.borderWidth = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassEffectCircle(
      diameter: size, // <-- use size, not borderWidth
      image: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
      borderWidth: borderWidth,
    );
  }
}

class GlassEffectCircle extends StatelessWidget {
  const GlassEffectCircle({
    super.key,
    required this.diameter,
    required this.image,
    this.borderWidth = 2,
  });

  final double diameter;
  final Widget image;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: diameter,
      height: diameter,
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
              decoration: BoxDecoration(
                color: gBlue.withOpacity(.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF23C1FF),
                  width: borderWidth,
                ),

              ),
            ),
            ),

            

            // Centered image with padding
            Center(
              child: Padding(
                padding: EdgeInsets.all(diameter * 0.1),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: diameter * 0.8,
                    height: diameter * 0.8,
                    child: image,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
