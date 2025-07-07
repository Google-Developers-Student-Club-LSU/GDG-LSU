import 'package:flutter/material.dart';

class Doorwidget extends StatelessWidget {
  final bool isLeft; 
  const Doorwidget( {
    super.key,
  required this.isLeft,
  });

  final double doorWidth = 150;
  final double doorHeight = 300;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: doorWidth,
      height: doorHeight,
      decoration: BoxDecoration(
        color: Colors.brown[700],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.brown[900]!, width: 3),
      ),
      child: Align(
        alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(right: isLeft ? 12 : 0, left: isLeft ? 0 : 12),
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.yellowAccent,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black)],
          ),
        ),
      ),
    );
  }

}