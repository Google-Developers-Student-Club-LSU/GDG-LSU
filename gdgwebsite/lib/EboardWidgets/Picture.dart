import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  final String assets;
  final double width;
  final double height;

  const Picture({
    super.key,
    required this.assets,
     this.width = 150,
     this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          assets,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
