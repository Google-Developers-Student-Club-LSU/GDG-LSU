import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonName; 
  final VoidCallback pressed;
  final Color color;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.buttonName,
    required this.pressed,
    this.color = gBlue,
    this.width, // optional width
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
