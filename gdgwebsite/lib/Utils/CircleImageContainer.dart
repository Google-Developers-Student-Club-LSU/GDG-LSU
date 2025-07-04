
import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class CircleImageContainer extends StatelessWidget {
  final double size;
  final String imagePath;
  final Color borderColor;
  final double borderWidth;

  const CircleImageContainer({
    Key? key,
    required this.imagePath,
    this.size = 100,
    this.borderColor = gBlue,
    this.borderWidth = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.white10 : Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          width: size * 0.8,
          height: size * 0.8,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
