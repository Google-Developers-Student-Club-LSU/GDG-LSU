import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonName; 
  final VoidCallback pressed;
  final Color color;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.buttonName,
    required this.pressed,
    this.color = gBlue,
    this.width = 100, 
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = width * 0.1;

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: pressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: darkBackgroundColor , width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: color, // or dark background
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: darkLetterColor, // Text color matches border
          ),
        ),
      ),
    );
  }
}
