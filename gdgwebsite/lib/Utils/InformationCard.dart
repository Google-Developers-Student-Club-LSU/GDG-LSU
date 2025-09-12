import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gdgwebsite/Colors.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({super.key, 
  required this.size, required this.description, required this.title});

  final Size size;
  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isMobile = size.width < 600;

    return SizedBox(
      width: size.width,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gBlue.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: gBlue.withOpacity(.28),
                width: 1.5,
              ),
            ),
            child: SingleChildScrollView( // prevents overflow but keeps card size
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: standardText.copyWith(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          gBlue.withOpacity(.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: standardText.copyWith(
                      fontSize: isMobile ? 14 : 16,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 25,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.index, required this.text, required this.isMobile});
  final int index;
  final String text;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index.",
            style: standardText.copyWith(
          
              fontSize: isMobile ? 16 : 18,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: standardText.copyWith(
               
                fontSize: isMobile ? 16 : 18,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}